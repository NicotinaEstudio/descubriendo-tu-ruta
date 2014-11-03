/**
 * Copyright 2014 Nicotina Estudio
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

#import "SubirFotoViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import "S3.h"
#import "Constantes.h"
#import <AFNetworking.h>

@interface SubirFotoViewController ()

@property (nonatomic, strong) NSURL *fileURL1;
@property (nonatomic, strong) AWSS3TransferManagerUploadRequest *uploadRequest1;
@property (nonatomic) uint64_t file1Size;
@property (nonatomic) uint64_t file1AlreadyUpload;
@property NSString *nombreImagen1;

@end

@implementation SubirFotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self cleanProgress];
    
    _arrImagenes = [[NSMutableArray alloc] init];
}

- (IBAction)btnSeleccionarFoto:(UIButton *)sender {
    
    // Solo una fotografías para prototipo
    if([self.arrImagenes count] == 1)
        return;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)btnSubir:(UIButton *)sender {
    
    // Subimos evidencias a Amazon
    
    // Nombre único para imagenes
    _nombreImagen1 = [NSString stringWithFormat:@"%@%@", [[NSUUID UUID] UUIDString], @".jpg"];
    
    NSData *imageData1 = UIImageJPEGRepresentation(self.imgPrevio.image, 1);
    NSString *filePath1 = [NSTemporaryDirectory() stringByAppendingPathComponent:_nombreImagen1];
    [imageData1 writeToFile:filePath1 atomically:YES];
    
    self.fileURL1 = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:_nombreImagen1]];
    
    self.file1Size = [imageData1 length];
    
    self.lblEstatus.text = StatusLabelUploading;
    
    [self cleanProgress];
    
    __weak typeof(self) weakSelf = self;
    
    self.uploadRequest1 = [AWSS3TransferManagerUploadRequest new];
    self.uploadRequest1.bucket = S3BucketName;
    self.uploadRequest1.key = _nombreImagen1;
    self.uploadRequest1.contentType = @"image/jpeg";
    self.uploadRequest1.body = self.fileURL1;
    self.uploadRequest1.uploadProgress =  ^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend){
        dispatch_sync(dispatch_get_main_queue(), ^{
            weakSelf.file1AlreadyUpload = totalBytesSent;
            [weakSelf updateProgress];
        });
    };
    
    [self uploadFiles];
}

- (IBAction)btnCerrar:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info
{
    NSString *tipoMedia = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *imgOriginal, *imgEditada, *imgAUsar;
    
    // Imagen seleccionada desde el album
    if (CFStringCompare ((CFStringRef) tipoMedia, kUTTypeImage, 0) == kCFCompareEqualTo)
    {
        imgEditada = (UIImage *) [info objectForKey: UIImagePickerControllerEditedImage];
        imgOriginal = (UIImage *) [info objectForKey: UIImagePickerControllerOriginalImage];
        
        if (imgEditada)
            imgAUsar = imgEditada;
        else
            imgAUsar = imgOriginal;
        
        NSString *URL = [((NSURL *)[info objectForKey:UIImagePickerControllerReferenceURL]) path];
        
        NSURL *picURL = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
        
        NSString *stringUrl = picURL.absoluteString;
        
        NSURL *asssetURL = [NSURL URLWithString:URL];
        
        if([self.arrImagenes count] == 0)
        {
            self.imgPrevio.image = imgAUsar;
            self.fileURL1 = picURL;
        }
        
        // Agregamos el path de la imagen selecionada al array de imagenes
        [self.arrImagenes addObject:imgAUsar];
    }
    
    [picker dismissModalViewControllerAnimated:YES];
}

- (void) cleanProgress
{
    self.pbEstatusSubida.progress = 0;
    self.file1AlreadyUpload = 0;
}

- (void)updateProgress
{
    if (self.file1AlreadyUpload <= self.file1Size)
        self.pbEstatusSubida.progress = (float)self.file1AlreadyUpload / (float)self.file1Size;
}

- (void) uploadFiles
{
    AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
    
    __block int uploadCount = 0;
    
    [[transferManager upload:self.uploadRequest1] continueWithExecutor:[BFExecutor mainThreadExecutor] withBlock:^id(BFTask *task) {
        if (task.error != nil) {
            if( task.error.code != AWSS3TransferManagerErrorCancelled
               &&
               task.error.code != AWSS3TransferManagerErrorPaused
               )
            {
                self.lblEstatus.text = StatusLabelFailed;
                NSLog(@"error %@", task.error);
            }
        } else {
            self.uploadRequest1 = nil;
            uploadCount ++;
            
            if(1 == uploadCount){
                self.lblEstatus.text = StatusLabelCompleted;
                [self enviaFoto:_nombreImagen1];
            }
        }
        return nil;
    }];
}

-(void) enviaFoto:(NSString *)foto
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary *params = @ {@"usuarioId" : @"1", @"foto" : _nombreImagen1};
    
    [manager POST:WebServiceDTR parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"JSON: %@", responseObject);
    }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
}
@end
