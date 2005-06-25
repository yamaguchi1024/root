// @(#)root/graf:$Name:  $:$Id: TImage.cxx,v 1.6 2005/06/14 15:29:06 rdm Exp $
// Author: Fons Rademakers   15/10/2001

/*************************************************************************
 * Copyright (C) 1995-2001, Rene Brun and Fons Rademakers.               *
 * All rights reserved.                                                  *
 *                                                                       *
 * For the licensing terms see $ROOTSYS/LICENSE.                         *
 * For the list of contributors see $ROOTSYS/README/CREDITS.             *
 *************************************************************************/

//////////////////////////////////////////////////////////////////////////
//                                                                      //
// TImage                                                               //
//                                                                      //
// Abstract interface to image processing library.                      //
// It allows for the reading and writing of images in different         //
// formats, several image manipulations (scaling, tiling, merging,      //
// etc.) and displaying in pads.                                        //
//                                                                      //
//////////////////////////////////////////////////////////////////////////

#include "TImage.h"
#include "TROOT.h"
#include "TPluginManager.h"

ClassImp(TImage)

//______________________________________________________________________________
TImage *TImage::Create()
{
   // Create an image. Use ReadImage() or SetImage() to initialize the image.

   static TPluginHandler *h = 0;

   TImage *img = 0;
   if (!h && (h = gROOT->GetPluginManager()->FindHandler("TImage"))) {
      if (!h) return 0;
      if (h->LoadPlugin() == -1) {
         h = 0;   // try to reload plugin next time
         return 0;
      }
      img = (TImage *) h->ExecPlugin(0);
      if (img) img->SetName("dummy_image");
   }
   return img;
}

//______________________________________________________________________________
TImage *TImage::Open(const char *file, EImageFileTypes type)
{
   // Open a specified image file.

   TImage *img = Create();

   if (img)
      img->ReadImage(file, type);

   return img;
}

//______________________________________________________________________________
TImage *TImage::Open(const char *name, const Double_t *imageData, UInt_t width,
                     UInt_t height, TImagePalette *palette)
{
   // Open an image with the specified data in a Double_t array.

   TImage *img = Create();

   if (img) {
      img->SetImage(imageData, width, height, palette);
      img->SetName(name);
   }
   return img;
}

//______________________________________________________________________________
TImage *TImage::Open(const char *name, const TArrayD &imageData, UInt_t width,
                     TImagePalette *palette)
{
   // Open an image with the specified data in a TArrayD.

   TImage *img = Create();

   if (img) {
      img->SetImage(imageData, width, palette);
      img->SetName(name);
   }
   return img;
}

//______________________________________________________________________________
TImage *TImage::Open(const char *name, const TVectorD &imageData, UInt_t width,
                     TImagePalette *palette)
{
   // Open an image with the specified data in a TVectorD.

   TImage *img = Create();

   if (img) {
      img->SetImage(imageData, width, palette);
      img->SetName(name);
   }
   return img;
}

//______________________________________________________________________________
TImage *TImage::Open(char **data)
{
   // create image from XPM data array

   TImage *img = Create();

   if (img) {
      img->SetImageBuffer(data, TImage::kXpm);
      img->SetName("XPM_image");
   }
   return img;
}


TImage operator+(const TImage &i1, const TImage &i2) { TImage ret(i1); ret.Append(&i2, "+"); return ret; }
TImage operator/(const TImage &i1, const TImage &i2) { TImage ret(i1); ret.Append(&i2, "/"); return ret; }


