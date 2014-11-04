/*
 * Copyright 2010-2014 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

#import "Constantes.h"

// TODO: Get the following Cognito constants via Cognito Console
NSString *const AWSAccountID = @"AWS-NOS-PROHIBE-TENERLA-EN-LINEA";
NSString *const CognitoPoolID = @"AWS-NOS-PROHIBE-TENERLA-EN-LINEA";
NSString *const CognitoRoleAuth = nil;
NSString *const CognitoRoleUnauth = @"AWS-NOS-PROHIBE-TENERLA-EN-LINEA";

NSString *const S3BucketName = @"descubriendo-tu-ruta";

NSString *const S3KeyDownloadName1 = @"image1.jpg";
NSString *const S3KeyDownloadName2 = @"image2.jpg";
NSString *const S3KeyDownloadName3 = @"image3.jpg";

NSString *const S3KeyUploadName1 = @"upload1.txt";
NSString *const S3KeyUploadName2 = @"upload2.txt";
NSString *const S3KeyUploadName3 = @"upload3.txt";

NSString *const LocalFileName1 = @"downloaded-image1.jpg";  
NSString *const LocalFileName2 = @"downloaded-image2.jpg";
NSString *const LocalFileName3 = @"downloaded-image3.jpg";

NSString *const StatusLabelReady = @"Listo";
NSString *const StatusLabelUploading = @"Cargando...";
NSString *const StatusLabelDownloading = @"Descargando...";
NSString *const StatusLabelFailed = @"Fallado";
NSString *const StatusLabelCompleted = @"Completado";

//NSString *const WebServiceDTR = @"http://localhost:8080/home/api/agregarFoto";
NSString *const WebServiceDTR = @"http://descubriendo-tu-ruta.herokuapp.com/home/api/agregarFoto/14";
