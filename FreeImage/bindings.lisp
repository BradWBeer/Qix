(in-package :FreeImage-Bindings)

(define-foreign-library libFreeImage
    (:unix (:or "libfreeimage.so.3" "libfreeimage.so")))

(use-foreign-library libFreeImage)

;;;SWIG wrapper code starts here

(cl:defmacro defanonenum (&body enums)
   "Converts anonymous enums to defconstants."
  `(cl:progn ,@(cl:loop for value in enums
                        for index = 0 then (cl:1+ index)
                        when (cl:listp value) do (cl:setf index (cl:second value)
                                                          value (cl:first value))
                        collect `(cl:defconstant ,value ,index))))

(cl:eval-when (:compile-toplevel :load-toplevel)
  (cl:unless (cl:fboundp 'swig-lispify)
    (cl:defun swig-lispify (name flag cl:&optional (package cl:*package*))
      (cl:labels ((helper (lst last rest cl:&aux (c (cl:car lst)))
                    (cl:cond
                      ((cl:null lst)
                       rest)
                      ((cl:upper-case-p c)
                       (helper (cl:cdr lst) 'upper
                               (cl:case last
                                 ((lower digit) (cl:list* c #\- rest))
                                 (cl:t (cl:cons c rest)))))
                      ((cl:lower-case-p c)
                       (helper (cl:cdr lst) 'lower (cl:cons (cl:char-upcase c) rest)))
                      ((cl:digit-char-p c)
                       (helper (cl:cdr lst) 'digit 
                               (cl:case last
                                 ((upper lower) (cl:list* c #\- rest))
                                 (cl:t (cl:cons c rest)))))
                      ((cl:char-equal c #\_)
                       (helper (cl:cdr lst) '_ (cl:cons #\- rest)))
                      (cl:t
                       (cl:error "Invalid character: ~A" c)))))
        (cl:let ((fix (cl:case flag
                        ((constant enumvalue) "+")
                        (variable "*")
                        (cl:t ""))))
          (cl:intern
           (cl:concatenate
            'cl:string
            fix
            (cl:nreverse (helper (cl:concatenate 'cl:list name) cl:nil cl:nil))
            fix)
           package))))))

;;;SWIG wrapper code ends here


(cl:defconstant FREEIMAGE_MAJOR_VERSION 3)

(cl:defconstant FREEIMAGE_MINOR_VERSION 13)

(cl:defconstant FREEIMAGE_RELEASE_SERIAL 1)

(cl:defconstant FREEIMAGE_COLORORDER_BGR 0)

(cl:defconstant FREEIMAGE_COLORORDER_RGB 1)

(cl:defconstant FREEIMAGE_COLORORDER 0)

(cffi:defcstruct FIBITMAP
	(data :pointer))

(cffi:defcstruct FIMULTIBITMAP
	(data :pointer))

(cl:defconstant FALSE 0)

(cl:defconstant TRUE 1)

(cl:defconstant NULL 0)

(cl:defconstant SEEK_SET 0)

(cl:defconstant SEEK_CUR 1)

(cl:defconstant SEEK_END 2)

(cffi:defcstruct RGBQUAD
	(rgbBlue :pointer)
	(rgbGreen :pointer)
	(rgbRed :pointer)
	(rgbReserved :pointer))

(cffi:defcstruct RGBTRIPLE
	(rgbtBlue :pointer)
	(rgbtGreen :pointer)
	(rgbtRed :pointer))

(cffi:defcstruct BITMAPINFOHEADER
	(biSize :pointer)
	(biWidth :pointer)
	(biHeight :pointer)
	(biPlanes :pointer)
	(biBitCount :pointer)
	(biCompression :pointer)
	(biSizeImage :pointer)
	(biXPelsPerMeter :pointer)
	(biYPelsPerMeter :pointer)
	(biClrUsed :pointer)
	(biClrImportant :pointer))

(cffi:defcstruct BITMAPINFO
	(bmiHeader BITMAPINFOHEADER)
	(bmiColors :pointer))

(cffi:defcstruct FIRGB16
	(red :pointer)
	(green :pointer)
	(blue :pointer))

(cffi:defcstruct FIRGBA16
	(red :pointer)
	(green :pointer)
	(blue :pointer)
	(alpha :pointer))

(cffi:defcstruct FIRGBF
	(red :float)
	(green :float)
	(blue :float))

(cffi:defcstruct FIRGBAF
	(red :float)
	(green :float)
	(blue :float)
	(alpha :float))

(cffi:defcstruct FICOMPLEX
	(r :double)
	(i :double))

(cl:defconstant FI_RGBA_RED 2)

(cl:defconstant FI_RGBA_GREEN 1)

(cl:defconstant FI_RGBA_BLUE 0)

(cl:defconstant FI_RGBA_ALPHA 3)

(cl:defconstant FI_RGBA_RED_MASK #x00FF0000)

(cl:defconstant FI_RGBA_GREEN_MASK #x0000FF00)

(cl:defconstant FI_RGBA_BLUE_MASK #x000000FF)

(cl:defconstant FI_RGBA_ALPHA_MASK #xFF000000)

(cl:defconstant FI_RGBA_RED_SHIFT 16)

(cl:defconstant FI_RGBA_GREEN_SHIFT 8)

(cl:defconstant FI_RGBA_BLUE_SHIFT 0)

(cl:defconstant FI_RGBA_ALPHA_SHIFT 24)

(cl:defconstant FI_RGBA_RGB_MASK (cl:logior #x00FF0000 #x0000FF00 #x000000FF))

(cl:defconstant FI16_555_RED_MASK #x7C00)

(cl:defconstant FI16_555_GREEN_MASK #x03E0)

(cl:defconstant FI16_555_BLUE_MASK #x001F)

(cl:defconstant FI16_555_RED_SHIFT 10)

(cl:defconstant FI16_555_GREEN_SHIFT 5)

(cl:defconstant FI16_555_BLUE_SHIFT 0)

(cl:defconstant FI16_565_RED_MASK #xF800)

(cl:defconstant FI16_565_GREEN_MASK #x07E0)

(cl:defconstant FI16_565_BLUE_MASK #x001F)

(cl:defconstant FI16_565_RED_SHIFT 11)

(cl:defconstant FI16_565_GREEN_SHIFT 5)

(cl:defconstant FI16_565_BLUE_SHIFT 0)

(cl:defconstant FIICC_DEFAULT #x00)

(cl:defconstant FIICC_COLOR_IS_CMYK #x01)

(cffi:defcstruct FIICCPROFILE
	(flags :pointer)
	(size :pointer)
	(data :pointer))

(cffi:defcstruct FIMETADATA
	(data :pointer))

(cffi:defcstruct FITAG
	(data :pointer))

(cffi:defcstruct FreeImageIO
	(read_proc :pointer)
	(write_proc :pointer)
	(seek_proc :pointer)
	(tell_proc :pointer))

(cffi:defcstruct FIMEMORY
	(data :pointer))

(cffi:defcstruct Plugin
	(format_proc :pointer)
	(description_proc :pointer)
	(extension_proc :pointer)
	(regexpr_proc :pointer)
	(open_proc :pointer)
	(close_proc :pointer)
	(pagecount_proc :pointer)
	(pagecapability_proc :pointer)
	(load_proc :pointer)
	(save_proc :pointer)
	(validate_proc :pointer)
	(mime_proc :pointer)
	(supports_export_bpp_proc :pointer)
	(supports_export_type_proc :pointer)
	(supports_icc_profiles_proc :pointer))

(cl:defconstant BMP_DEFAULT 0)

(cl:defconstant BMP_SAVE_RLE 1)

(cl:defconstant CUT_DEFAULT 0)

(cl:defconstant DDS_DEFAULT 0)

(cl:defconstant EXR_DEFAULT 0)

(cl:defconstant EXR_FLOAT #x0001)

(cl:defconstant EXR_NONE #x0002)

(cl:defconstant EXR_ZIP #x0004)

(cl:defconstant EXR_PIZ #x0008)

(cl:defconstant EXR_PXR24 #x0010)

(cl:defconstant EXR_B44 #x0020)

(cl:defconstant EXR_LC #x0040)

(cl:defconstant FAXG3_DEFAULT 0)

(cl:defconstant GIF_DEFAULT 0)

(cl:defconstant GIF_LOAD256 1)

(cl:defconstant GIF_PLAYBACK 2)

(cl:defconstant HDR_DEFAULT 0)

(cl:defconstant ICO_DEFAULT 0)

(cl:defconstant ICO_MAKEALPHA 1)

(cl:defconstant IFF_DEFAULT 0)

(cl:defconstant J2K_DEFAULT 0)

(cl:defconstant JP2_DEFAULT 0)

(cl:defconstant JPEG_DEFAULT 0)

(cl:defconstant JPEG_FAST #x0001)

(cl:defconstant JPEG_ACCURATE #x0002)

(cl:defconstant JPEG_CMYK #x0004)

(cl:defconstant JPEG_EXIFROTATE #x0008)

(cl:defconstant JPEG_QUALITYSUPERB #x80)

(cl:defconstant JPEG_QUALITYGOOD #x0100)

(cl:defconstant JPEG_QUALITYNORMAL #x0200)

(cl:defconstant JPEG_QUALITYAVERAGE #x0400)

(cl:defconstant JPEG_QUALITYBAD #x0800)

(cl:defconstant JPEG_PROGRESSIVE #x2000)

(cl:defconstant JPEG_SUBSAMPLING_411 #x1000)

(cl:defconstant JPEG_SUBSAMPLING_420 #x4000)

(cl:defconstant JPEG_SUBSAMPLING_422 #x8000)

(cl:defconstant JPEG_SUBSAMPLING_444 #x10000)

(cl:defconstant KOALA_DEFAULT 0)

(cl:defconstant LBM_DEFAULT 0)

(cl:defconstant MNG_DEFAULT 0)

(cl:defconstant PCD_DEFAULT 0)

(cl:defconstant PCD_BASE 1)

(cl:defconstant PCD_BASEDIV4 2)

(cl:defconstant PCD_BASEDIV16 3)

(cl:defconstant PCX_DEFAULT 0)

(cl:defconstant PFM_DEFAULT 0)

(cl:defconstant PICT_DEFAULT 0)

(cl:defconstant PNG_DEFAULT 0)

(cl:defconstant PNG_IGNOREGAMMA 1)

(cl:defconstant PNG_Z_BEST_SPEED #x0001)

(cl:defconstant PNG_Z_DEFAULT_COMPRESSION #x0006)

(cl:defconstant PNG_Z_BEST_COMPRESSION #x0009)

(cl:defconstant PNG_Z_NO_COMPRESSION #x0100)

(cl:defconstant PNG_INTERLACED #x0200)

(cl:defconstant PNM_DEFAULT 0)

(cl:defconstant PNM_SAVE_RAW 0)

(cl:defconstant PNM_SAVE_ASCII 1)

(cl:defconstant PSD_DEFAULT 0)

(cl:defconstant RAS_DEFAULT 0)

(cl:defconstant RAW_DEFAULT 0)

(cl:defconstant RAW_PREVIEW 1)

(cl:defconstant RAW_DISPLAY 2)

(cl:defconstant SGI_DEFAULT 0)

(cl:defconstant TARGA_DEFAULT 0)

(cl:defconstant TARGA_LOAD_RGB888 1)

(cl:defconstant TIFF_DEFAULT 0)

(cl:defconstant TIFF_CMYK #x0001)

(cl:defconstant TIFF_PACKBITS #x0100)

(cl:defconstant TIFF_DEFLATE #x0200)

(cl:defconstant TIFF_ADOBE_DEFLATE #x0400)

(cl:defconstant TIFF_NONE #x0800)

(cl:defconstant TIFF_CCITTFAX3 #x1000)

(cl:defconstant TIFF_CCITTFAX4 #x2000)

(cl:defconstant TIFF_LZW #x4000)

(cl:defconstant TIFF_JPEG #x8000)

(cl:defconstant WBMP_DEFAULT 0)

(cl:defconstant XBM_DEFAULT 0)

(cl:defconstant XPM_DEFAULT 0)

(cl:defconstant FI_COLOR_IS_RGB_COLOR #x00)

(cl:defconstant FI_COLOR_IS_RGBA_COLOR #x01)

(cl:defconstant FI_COLOR_FIND_EQUAL_COLOR #x02)

(cl:defconstant FI_COLOR_ALPHA_IS_INDEX #x04)

(cl:defconstant FI_COLOR_PALETTE_SEARCH_MASK (cl:logior #x02 #x04))

(cffi:defcenum FREE-IMAGE-FORMAT
	   (:FIF-UNKNOWN -1)
	   (:FIF-BMP 0)
	   (:FIF-ICO 1)
	   (:FIF-JPEG 2)
	   (:FIF-JNG 3)
	   (:FIF-KOALA 4)
	   (:FIF-LBM 5)
	   (:FIF-IFF 5)
	   (:FIF-MNG 6)
	   (:FIF-PBM 7)
	   (:FIF-PBMRAW 8)
	   (:FIF-PCD 9)
	   (:FIF-PCX 10)
	   (:FIF-PGM 11)
	   (:FIF-PGMRAW 12)
	   (:FIF-PNG 13)
	   (:FIF-PPM 14)
	   (:FIF-PPMRAW 15)
	   (:FIF-RAS 16)
	   (:FIF-TARGA 17)
	   (:FIF-TIFF 18)
	   (:FIF-WBMP 19)
	   (:FIF-PSD 20)
	   (:FIF-CUT 21)
	   (:FIF-XBM 22)
	   (:FIF-XPM 23)
	   (:FIF-DDS 24)
	   (:FIF-GIF 25)
	   (:FIF-HDR 26)
	   (:FIF-FAXG3 27)
	   (:FIF-SGI 28)
	   (:FIF-EXR 29)
	   (:FIF-J2K 30)
	   (:FIF-JP2 31)
	   (:FIF-PFM 32)
	   (:FIF-PICT 33)
	   (:FIF-RAW 34))


(cffi:defcenum FREE-IMAGE-MDMODEL
  (:FIMD-NODATA -1)
  (:FIMD-COMMENTS 0)  ;single comment or keywords
  (:FIMD-EXIF-MAIN 1) ;Exif-TIFF metadata
  (:FIMD-EXIF-EXIF 2) ;Exif-specific metadata
  (:FIMD-EXIF-GPS 3)  ;Exif GPS metadata
  (:FIMD-EXIF-MAKERNOTE 4) ;Exif maker note metadata
  (:FIMD-EXIF-INTEROP 5)   ;Exif interoperability metadata
  (:FIMD-IPTC 6)           ;IPTC/NAA metadata
  (:FIMD-XMP 7)       ;Abobe XMP metadata
  (:FIMD-GEOTIFF 8)   ;GeoTIFF metadata
  (:FIMD-ANIMATION 9) ;Animation metadata
  (:FIMD-CUSTOM	10))  ;Used to attach other metadata types to a dib



(cffi:defcfun ("FreeImage_Initialise" FreeImage_Initialise) :void
  (load_local_plugins_only :pointer))

(cffi:defcfun ("FreeImage_DeInitialise" FreeImage_DeInitialise) :void)

(cffi:defcfun ("FreeImage_GetVersion" FreeImage_GetVersion) :string)

(cffi:defcfun ("FreeImage_GetCopyrightMessage" FreeImage_GetCopyrightMessage) :string)

(cffi:defcfun ("FreeImage_SetOutputMessageStdCall" FreeImage_SetOutputMessageStdCall) :void
  (omf :pointer))

(cffi:defcfun ("FreeImage_SetOutputMessage" FreeImage_SetOutputMessage) :void
  (omf :pointer))

(cffi:defcfun ("FreeImage_OutputMessageProc" FreeImage_OutputMessageProc) :void
  (fif :int)
  (fmt :string)
  &rest)

(cffi:defcfun ("FreeImage_Allocate" FreeImage_Allocate) :pointer
  (width :int)
  (height :int)
  (bpp :int)
  (red_mask :unsigned-int)
  (green_mask :unsigned-int)
  (blue_mask :unsigned-int))

(cffi:defcfun ("FreeImage_AllocateT" FreeImage_AllocateT) :pointer
  (type :int)
  (width :int)
  (height :int)
  (bpp :int)
  (red_mask :unsigned-int)
  (green_mask :unsigned-int)
  (blue_mask :unsigned-int))

(cffi:defcfun ("FreeImage_Clone" FreeImage_Clone) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_Unload" FreeImage_Unload) :void
  (dib :pointer))

(cffi:defcfun ("FreeImage_Load" FreeImage_Load) :pointer
  (fif FREE-IMAGE-FORMAT)
  (filename :string)
  (flags :int))

(cffi:defcfun ("FreeImage_LoadU" FreeImage_LoadU) :pointer
  (fif :int)
  (filename :pointer)
  (flags :int))

(cffi:defcfun ("FreeImage_LoadFromHandle" FreeImage_LoadFromHandle) :pointer
  (fif :int)
  (io :pointer)
  (handle :pointer)
  (flags :int))

(cffi:defcfun ("FreeImage_Save" FreeImage_Save) :pointer
  (fif :int)
  (dib :pointer)
  (filename :string)
  (flags :int))

(cffi:defcfun ("FreeImage_SaveU" FreeImage_SaveU) :pointer
  (fif :int)
  (dib :pointer)
  (filename :pointer)
  (flags :int))

(cffi:defcfun ("FreeImage_SaveToHandle" FreeImage_SaveToHandle) :pointer
  (fif :int)
  (dib :pointer)
  (io :pointer)
  (handle :pointer)
  (flags :int))

(cffi:defcfun ("FreeImage_OpenMemory" FreeImage_OpenMemory) :pointer
  (data :pointer)
  (size_in_bytes :pointer))

(cffi:defcfun ("FreeImage_CloseMemory" FreeImage_CloseMemory) :void
  (stream :pointer))

(cffi:defcfun ("FreeImage_LoadFromMemory" FreeImage_LoadFromMemory) :pointer
  (fif :int)
  (stream :pointer)
  (flags :int))

(cffi:defcfun ("FreeImage_SaveToMemory" FreeImage_SaveToMemory) :pointer
  (fif :int)
  (dib :pointer)
  (stream :pointer)
  (flags :int))

(cffi:defcfun ("FreeImage_TellMemory" FreeImage_TellMemory) :long
  (stream :pointer))

(cffi:defcfun ("FreeImage_SeekMemory" FreeImage_SeekMemory) :pointer
  (stream :pointer)
  (offset :long)
  (origin :int))

(cffi:defcfun ("FreeImage_AcquireMemory" FreeImage_AcquireMemory) :pointer
  (stream :pointer)
  (data :pointer)
  (size_in_bytes :pointer))

(cffi:defcfun ("FreeImage_ReadMemory" FreeImage_ReadMemory) :unsigned-int
  (buffer :pointer)
  (size :unsigned-int)
  (count :unsigned-int)
  (stream :pointer))

(cffi:defcfun ("FreeImage_WriteMemory" FreeImage_WriteMemory) :unsigned-int
  (buffer :pointer)
  (size :unsigned-int)
  (count :unsigned-int)
  (stream :pointer))

(cffi:defcfun ("FreeImage_LoadMultiBitmapFromMemory" FreeImage_LoadMultiBitmapFromMemory) :pointer
  (fif :int)
  (stream :pointer)
  (flags :int))

(cffi:defcfun ("FreeImage_RegisterLocalPlugin" FreeImage_RegisterLocalPlugin) :int
  (proc_address :pointer)
  (format :string)
  (description :string)
  (extension :string)
  (regexpr :string))

(cffi:defcfun ("FreeImage_RegisterExternalPlugin" FreeImage_RegisterExternalPlugin) :int
  (path :string)
  (format :string)
  (description :string)
  (extension :string)
  (regexpr :string))

(cffi:defcfun ("FreeImage_GetFIFCount" FreeImage_GetFIFCount) :int)

(cffi:defcfun ("FreeImage_SetPluginEnabled" FreeImage_SetPluginEnabled) :int
  (fif :int)
  (enable :pointer))

(cffi:defcfun ("FreeImage_IsPluginEnabled" FreeImage_IsPluginEnabled) :int
  (fif :int))

(cffi:defcfun ("FreeImage_GetFIFFromFormat" FreeImage_GetFIFFromFormat) :int
  (format :string))

(cffi:defcfun ("FreeImage_GetFIFFromMime" FreeImage_GetFIFFromMime) :int
  (mime :string))

(cffi:defcfun ("FreeImage_GetFormatFromFIF" FreeImage_GetFormatFromFIF) :string
  (fif :int))

(cffi:defcfun ("FreeImage_GetFIFExtensionList" FreeImage_GetFIFExtensionList) :string
  (fif :int))

(cffi:defcfun ("FreeImage_GetFIFDescription" FreeImage_GetFIFDescription) :string
  (fif :int))

(cffi:defcfun ("FreeImage_GetFIFRegExpr" FreeImage_GetFIFRegExpr) :string
  (fif :int))

(cffi:defcfun ("FreeImage_GetFIFMimeType" FreeImage_GetFIFMimeType) :string
  (fif :int))

(cffi:defcfun ("FreeImage_GetFIFFromFilename" FreeImage_GetFIFFromFilename) :int
  (filename :string))

(cffi:defcfun ("FreeImage_GetFIFFromFilenameU" FreeImage_GetFIFFromFilenameU) :int
  (filename :pointer))

(cffi:defcfun ("FreeImage_FIFSupportsReading" FreeImage_FIFSupportsReading) :pointer
  (fif :int))

(cffi:defcfun ("FreeImage_FIFSupportsWriting" FreeImage_FIFSupportsWriting) :pointer
  (fif :int))

(cffi:defcfun ("FreeImage_FIFSupportsExportBPP" FreeImage_FIFSupportsExportBPP) :pointer
  (fif :int)
  (bpp :int))

(cffi:defcfun ("FreeImage_FIFSupportsExportType" FreeImage_FIFSupportsExportType) :pointer
  (fif :int)
  (type :int))

(cffi:defcfun ("FreeImage_FIFSupportsICCProfiles" FreeImage_FIFSupportsICCProfiles) :pointer
  (fif :int))

(cffi:defcfun ("FreeImage_OpenMultiBitmap" FreeImage_OpenMultiBitmap) :pointer
  (fif FREE-IMAGE-FORMAT)
  (filename :string)
  (create_new :int)
  (read_only :int)
  (keep_cache_in_memory :int)
  (flags :pointer))

(cffi:defcfun ("FreeImage_OpenMultiBitmapFromHandle" FreeImage_OpenMultiBitmapFromHandle) :pointer
  (fif :int)
  (io :pointer)
  (handle :pointer)
  (flags :int))

(cffi:defcfun ("FreeImage_CloseMultiBitmap" FreeImage_CloseMultiBitmap) :pointer
  (bitmap :pointer)
  (flags :int))

(cffi:defcfun ("FreeImage_GetPageCount" FreeImage_GetPageCount) :int
  (bitmap :pointer))

(cffi:defcfun ("FreeImage_AppendPage" FreeImage_AppendPage) :void
  (bitmap :pointer)
  (data :pointer))

(cffi:defcfun ("FreeImage_InsertPage" FreeImage_InsertPage) :void
  (bitmap :pointer)
  (page :int)
  (data :pointer))

(cffi:defcfun ("FreeImage_DeletePage" FreeImage_DeletePage) :void
  (bitmap :pointer)
  (page :int))

(cffi:defcfun ("FreeImage_LockPage" FreeImage_LockPage) :pointer
  (bitmap :pointer)
  (page :int))

(cffi:defcfun ("FreeImage_UnlockPage" FreeImage_UnlockPage) :void
  (bitmap :pointer)
  (data :pointer)
  (changed :int))

(cffi:defcfun ("FreeImage_MovePage" FreeImage_MovePage) :pointer
  (bitmap :pointer)
  (target :int)
  (source :int))

(cffi:defcfun ("FreeImage_GetLockedPageNumbers" FreeImage_GetLockedPageNumbers) :pointer
  (bitmap :pointer)
  (pages :pointer)
  (count :pointer))

(cffi:defcfun ("FreeImage_GetFileType" FreeImage_GetFileType) FREE-IMAGE-FORMAT
  (filename :string)
  (size :int))

(cffi:defcfun ("FreeImage_GetFileTypeU" FreeImage_GetFileTypeU) :int
  (filename :pointer)
  (size :int))

(cffi:defcfun ("FreeImage_GetFileTypeFromHandle" FreeImage_GetFileTypeFromHandle) :int
  (io :pointer)
  (handle :pointer)
  (size :int))

(cffi:defcfun ("FreeImage_GetFileTypeFromMemory" FreeImage_GetFileTypeFromMemory) :int
  (stream :pointer)
  (size :int))

(cffi:defcfun ("FreeImage_GetImageType" FreeImage_GetImageType) :int
  (dib :pointer))

(cffi:defcfun ("FreeImage_IsLittleEndian" FreeImage_IsLittleEndian) :pointer)

(cffi:defcfun ("FreeImage_LookupX11Color" FreeImage_LookupX11Color) :pointer
  (szColor :string)
  (nRed :pointer)
  (nGreen :pointer)
  (nBlue :pointer))

(cffi:defcfun ("FreeImage_LookupSVGColor" FreeImage_LookupSVGColor) :pointer
  (szColor :string)
  (nRed :pointer)
  (nGreen :pointer)
  (nBlue :pointer))

(cffi:defcfun ("FreeImage_GetBits" FreeImage_GetBits) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_GetScanLine" FreeImage_GetScanLine) :pointer
  (dib :pointer)
  (scanline :int))

(cffi:defcfun ("FreeImage_GetPixelIndex" FreeImage_GetPixelIndex) :pointer
  (dib :pointer)
  (x :unsigned-int)
  (y :unsigned-int)
  (value :pointer))

(cffi:defcfun ("FreeImage_GetPixelColor" FreeImage_GetPixelColor) :pointer
  (dib :pointer)
  (x :unsigned-int)
  (y :unsigned-int)
  (value :pointer))

(cffi:defcfun ("FreeImage_SetPixelIndex" FreeImage_SetPixelIndex) :pointer
  (dib :pointer)
  (x :unsigned-int)
  (y :unsigned-int)
  (value :pointer))

(cffi:defcfun ("FreeImage_SetPixelColor" FreeImage_SetPixelColor) :pointer
  (dib :pointer)
  (x :unsigned-int)
  (y :unsigned-int)
  (value :pointer))

(cffi:defcfun ("FreeImage_GetColorsUsed" FreeImage_GetColorsUsed) :unsigned-int
  (dib :pointer))

(cffi:defcfun ("FreeImage_GetBPP" FreeImage_GetBPP) :unsigned-int
  (dib :pointer))

(cffi:defcfun ("FreeImage_GetWidth" FreeImage_GetWidth) :unsigned-int
  (dib :pointer))

(cffi:defcfun ("FreeImage_GetHeight" FreeImage_GetHeight) :unsigned-int
  (dib :pointer))

(cffi:defcfun ("FreeImage_GetLine" FreeImage_GetLine) :unsigned-int
  (dib :pointer))

(cffi:defcfun ("FreeImage_GetPitch" FreeImage_GetPitch) :unsigned-int
  (dib :pointer))

(cffi:defcfun ("FreeImage_GetDIBSize" FreeImage_GetDIBSize) :unsigned-int
  (dib :pointer))

(cffi:defcfun ("FreeImage_GetPalette" FreeImage_GetPalette) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_GetDotsPerMeterX" FreeImage_GetDotsPerMeterX) :unsigned-int
  (dib :pointer))

(cffi:defcfun ("FreeImage_GetDotsPerMeterY" FreeImage_GetDotsPerMeterY) :unsigned-int
  (dib :pointer))

(cffi:defcfun ("FreeImage_SetDotsPerMeterX" FreeImage_SetDotsPerMeterX) :void
  (dib :pointer)
  (res :unsigned-int))

(cffi:defcfun ("FreeImage_SetDotsPerMeterY" FreeImage_SetDotsPerMeterY) :void
  (dib :pointer)
  (res :unsigned-int))

(cffi:defcfun ("FreeImage_GetInfoHeader" FreeImage_GetInfoHeader) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_GetInfo" FreeImage_GetInfo) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_GetColorType" FreeImage_GetColorType) :int
  (dib :pointer))

(cffi:defcfun ("FreeImage_GetRedMask" FreeImage_GetRedMask) :unsigned-int
  (dib :pointer))

(cffi:defcfun ("FreeImage_GetGreenMask" FreeImage_GetGreenMask) :unsigned-int
  (dib :pointer))

(cffi:defcfun ("FreeImage_GetBlueMask" FreeImage_GetBlueMask) :unsigned-int
  (dib :pointer))

(cffi:defcfun ("FreeImage_GetTransparencyCount" FreeImage_GetTransparencyCount) :unsigned-int
  (dib :pointer))

(cffi:defcfun ("FreeImage_GetTransparencyTable" FreeImage_GetTransparencyTable) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_SetTransparent" FreeImage_SetTransparent) :void
  (dib :pointer)
  (enabled :pointer))

(cffi:defcfun ("FreeImage_SetTransparencyTable" FreeImage_SetTransparencyTable) :void
  (dib :pointer)
  (table :pointer)
  (count :int))

(cffi:defcfun ("FreeImage_IsTransparent" FreeImage_IsTransparent) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_SetTransparentIndex" FreeImage_SetTransparentIndex) :void
  (dib :pointer)
  (index :int))

(cffi:defcfun ("FreeImage_GetTransparentIndex" FreeImage_GetTransparentIndex) :int
  (dib :pointer))

(cffi:defcfun ("FreeImage_HasBackgroundColor" FreeImage_HasBackgroundColor) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_GetBackgroundColor" FreeImage_GetBackgroundColor) :pointer
  (dib :pointer)
  (bkcolor :pointer))

(cffi:defcfun ("FreeImage_SetBackgroundColor" FreeImage_SetBackgroundColor) :pointer
  (dib :pointer)
  (bkcolor :pointer))

(cffi:defcfun ("FreeImage_GetICCProfile" FreeImage_GetICCProfile) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_CreateICCProfile" FreeImage_CreateICCProfile) :pointer
  (dib :pointer)
  (data :pointer)
  (size :long))

(cffi:defcfun ("FreeImage_DestroyICCProfile" FreeImage_DestroyICCProfile) :void
  (dib :pointer))

(cffi:defcfun ("FreeImage_ConvertLine1To4" FreeImage_ConvertLine1To4) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine8To4" FreeImage_ConvertLine8To4) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int)
  (palette :pointer))

(cffi:defcfun ("FreeImage_ConvertLine16To4_555" FreeImage_ConvertLine16To4_555) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine16To4_565" FreeImage_ConvertLine16To4_565) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine24To4" FreeImage_ConvertLine24To4) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine32To4" FreeImage_ConvertLine32To4) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine1To8" FreeImage_ConvertLine1To8) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine4To8" FreeImage_ConvertLine4To8) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine16To8_555" FreeImage_ConvertLine16To8_555) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine16To8_565" FreeImage_ConvertLine16To8_565) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine24To8" FreeImage_ConvertLine24To8) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine32To8" FreeImage_ConvertLine32To8) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine1To16_555" FreeImage_ConvertLine1To16_555) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int)
  (palette :pointer))

(cffi:defcfun ("FreeImage_ConvertLine4To16_555" FreeImage_ConvertLine4To16_555) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int)
  (palette :pointer))

(cffi:defcfun ("FreeImage_ConvertLine8To16_555" FreeImage_ConvertLine8To16_555) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int)
  (palette :pointer))

(cffi:defcfun ("FreeImage_ConvertLine16_565_To16_555" FreeImage_ConvertLine16_565_To16_555) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine24To16_555" FreeImage_ConvertLine24To16_555) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine32To16_555" FreeImage_ConvertLine32To16_555) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine1To16_565" FreeImage_ConvertLine1To16_565) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int)
  (palette :pointer))

(cffi:defcfun ("FreeImage_ConvertLine4To16_565" FreeImage_ConvertLine4To16_565) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int)
  (palette :pointer))

(cffi:defcfun ("FreeImage_ConvertLine8To16_565" FreeImage_ConvertLine8To16_565) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int)
  (palette :pointer))

(cffi:defcfun ("FreeImage_ConvertLine16_555_To16_565" FreeImage_ConvertLine16_555_To16_565) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine24To16_565" FreeImage_ConvertLine24To16_565) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine32To16_565" FreeImage_ConvertLine32To16_565) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine1To24" FreeImage_ConvertLine1To24) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int)
  (palette :pointer))

(cffi:defcfun ("FreeImage_ConvertLine4To24" FreeImage_ConvertLine4To24) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int)
  (palette :pointer))

(cffi:defcfun ("FreeImage_ConvertLine8To24" FreeImage_ConvertLine8To24) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int)
  (palette :pointer))

(cffi:defcfun ("FreeImage_ConvertLine16To24_555" FreeImage_ConvertLine16To24_555) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine16To24_565" FreeImage_ConvertLine16To24_565) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine32To24" FreeImage_ConvertLine32To24) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine1To32" FreeImage_ConvertLine1To32) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int)
  (palette :pointer))

(cffi:defcfun ("FreeImage_ConvertLine4To32" FreeImage_ConvertLine4To32) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int)
  (palette :pointer))

(cffi:defcfun ("FreeImage_ConvertLine8To32" FreeImage_ConvertLine8To32) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int)
  (palette :pointer))

(cffi:defcfun ("FreeImage_ConvertLine16To32_555" FreeImage_ConvertLine16To32_555) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine16To32_565" FreeImage_ConvertLine16To32_565) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertLine24To32" FreeImage_ConvertLine24To32) :void
  (target :pointer)
  (source :pointer)
  (width_in_pixels :int))

(cffi:defcfun ("FreeImage_ConvertTo4Bits" FreeImage_ConvertTo4Bits) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_ConvertTo8Bits" FreeImage_ConvertTo8Bits) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_ConvertToGreyscale" FreeImage_ConvertToGreyscale) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_ConvertTo16Bits555" FreeImage_ConvertTo16Bits555) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_ConvertTo16Bits565" FreeImage_ConvertTo16Bits565) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_ConvertTo24Bits" FreeImage_ConvertTo24Bits) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_ConvertTo32Bits" FreeImage_ConvertTo32Bits) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_ColorQuantize" FreeImage_ColorQuantize) :pointer
  (dib :pointer)
  (quantize :int))

(cffi:defcfun ("FreeImage_ColorQuantizeEx" FreeImage_ColorQuantizeEx) :pointer
  (dib :pointer)
  (quantize :int)
  (PaletteSize :int)
  (ReserveSize :int)
  (ReservePalette :pointer))

(cffi:defcfun ("FreeImage_Threshold" FreeImage_Threshold) :pointer
  (dib :pointer)
  (t_arg1 :pointer))

(cffi:defcfun ("FreeImage_Dither" FreeImage_Dither) :pointer
  (dib :pointer)
  (algorithm :int))

(cffi:defcfun ("FreeImage_ConvertFromRawBits" FreeImage_ConvertFromRawBits) :pointer
  (bits :pointer)
  (width :int)
  (height :int)
  (pitch :int)
  (bpp :unsigned-int)
  (red_mask :unsigned-int)
  (green_mask :unsigned-int)
  (blue_mask :unsigned-int)
  (topdown :pointer))

(cffi:defcfun ("FreeImage_ConvertToRawBits" FreeImage_ConvertToRawBits) :void
  (bits :pointer)
  (dib :pointer)
  (pitch :int)
  (bpp :unsigned-int)
  (red_mask :unsigned-int)
  (green_mask :unsigned-int)
  (blue_mask :unsigned-int)
  (topdown :pointer))

(cffi:defcfun ("FreeImage_ConvertToRGBF" FreeImage_ConvertToRGBF) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_ConvertToStandardType" FreeImage_ConvertToStandardType) :pointer
  (src :pointer)
  (scale_linear :pointer))

(cffi:defcfun ("FreeImage_ConvertToType" FreeImage_ConvertToType) :pointer
  (src :pointer)
  (dst_type :int)
  (scale_linear :pointer))

(cffi:defcfun ("FreeImage_ToneMapping" FreeImage_ToneMapping) :pointer
  (dib :pointer)
  (tmo :int)
  (first_param :double)
  (second_param :double))

(cffi:defcfun ("FreeImage_TmoDrago03" FreeImage_TmoDrago03) :pointer
  (src :pointer)
  (gamma :double)
  (exposure :double))

(cffi:defcfun ("FreeImage_TmoReinhard05" FreeImage_TmoReinhard05) :pointer
  (src :pointer)
  (intensity :double)
  (contrast :double))

(cffi:defcfun ("FreeImage_TmoReinhard05Ex" FreeImage_TmoReinhard05Ex) :pointer
  (src :pointer)
  (intensity :double)
  (contrast :double)
  (adaptation :double)
  (color_correction :double))

(cffi:defcfun ("FreeImage_TmoFattal02" FreeImage_TmoFattal02) :pointer
  (src :pointer)
  (color_saturation :double)
  (attenuation :double))

(cffi:defcfun ("FreeImage_ZLibCompress" FreeImage_ZLibCompress) :pointer
  (target :pointer)
  (target_size :pointer)
  (source :pointer)
  (source_size :pointer))

(cffi:defcfun ("FreeImage_ZLibUncompress" FreeImage_ZLibUncompress) :pointer
  (target :pointer)
  (target_size :pointer)
  (source :pointer)
  (source_size :pointer))

(cffi:defcfun ("FreeImage_ZLibGZip" FreeImage_ZLibGZip) :pointer
  (target :pointer)
  (target_size :pointer)
  (source :pointer)
  (source_size :pointer))

(cffi:defcfun ("FreeImage_ZLibGUnzip" FreeImage_ZLibGUnzip) :pointer
  (target :pointer)
  (target_size :pointer)
  (source :pointer)
  (source_size :pointer))

(cffi:defcfun ("FreeImage_ZLibCRC32" FreeImage_ZLibCRC32) :pointer
  (crc :pointer)
  (source :pointer)
  (source_size :pointer))

(cffi:defcfun ("FreeImage_CreateTag" FreeImage_CreateTag) :pointer)

(cffi:defcfun ("FreeImage_DeleteTag" FreeImage_DeleteTag) :void
  (tag :pointer))

(cffi:defcfun ("FreeImage_CloneTag" FreeImage_CloneTag) :pointer
  (tag :pointer))

(cffi:defcfun ("FreeImage_GetTagKey" FreeImage_GetTagKey) :string
  (tag :pointer))

(cffi:defcfun ("FreeImage_GetTagDescription" FreeImage_GetTagDescription) :string
  (tag :pointer))

(cffi:defcfun ("FreeImage_GetTagID" FreeImage_GetTagID) :pointer
  (tag :pointer))

(cffi:defcfun ("FreeImage_GetTagType" FreeImage_GetTagType) :int
  (tag :pointer))

(cffi:defcfun ("FreeImage_GetTagCount" FreeImage_GetTagCount) :int
  (tag :pointer))

(cffi:defcfun ("FreeImage_GetTagLength" FreeImage_GetTagLength) :pointer
  (tag :pointer))

(cffi:defcfun ("FreeImage_GetTagValue" FreeImage_GetTagValue) :pointer
  (tag :pointer))

(cffi:defcfun ("FreeImage_SetTagKey" FreeImage_SetTagKey) :pointer
  (tag :pointer)
  (key :string))

(cffi:defcfun ("FreeImage_SetTagDescription" FreeImage_SetTagDescription) :pointer
  (tag :pointer)
  (description :string))

(cffi:defcfun ("FreeImage_SetTagID" FreeImage_SetTagID) :pointer
  (tag :pointer)
  (id :pointer))

(cffi:defcfun ("FreeImage_SetTagType" FreeImage_SetTagType) :pointer
  (tag :pointer)
  (type :int))

(cffi:defcfun ("FreeImage_SetTagCount" FreeImage_SetTagCount) :pointer
  (tag :pointer)
  (count :pointer))

(cffi:defcfun ("FreeImage_SetTagLength" FreeImage_SetTagLength) :pointer
  (tag :pointer)
  (length :pointer))

(cffi:defcfun ("FreeImage_SetTagValue" FreeImage_SetTagValue) :pointer
  (tag :pointer)
  (value :pointer))

(cffi:defcfun ("FreeImage_FindFirstMetadata" FreeImage_FindFirstMetadata) :pointer
  (model FREE-IMAGE-MDMODEL)
  (dib :pointer)
  (tag :pointer))

(cffi:defcfun ("FreeImage_FindNextMetadata" FreeImage_FindNextMetadata) :pointer
  (mdhandle :pointer)
  (tag :pointer))

(cffi:defcfun ("FreeImage_FindCloseMetadata" FreeImage_FindCloseMetadata) :void
  (mdhandle :pointer))

(cffi:defcfun ("FreeImage_SetMetadata" FreeImage_SetMetadata) :pointer
  (model FREE-IMAGE-MDMODEL)
  (dib :pointer)
  (key :string)
  (tag :pointer))

(cffi:defcfun ("FreeImage_GetMetadata" FreeImage_GetMetadata) :int
  (model FREE-IMAGE-MDMODEL)
  (dib :pointer)
  (key :string)
  (tag :pointer))

(cffi:defcfun ("FreeImage_GetMetadataCount" FreeImage_GetMetadataCount) :unsigned-int
  (model :int)
  (dib :pointer))

(cffi:defcfun ("FreeImage_CloneMetadata" FreeImage_CloneMetadata) :pointer
  (dst :pointer)
  (src :pointer))

(cffi:defcfun ("FreeImage_TagToString" FreeImage_TagToString) :string
  (model :int)
  (tag :pointer)
  (Make :string))

(cffi:defcfun ("FreeImage_RotateClassic" FreeImage_RotateClassic) :pointer
  (dib :pointer)
  (angle :double))

(cffi:defcfun ("FreeImage_Rotate" FreeImage_Rotate) :pointer
  (dib :pointer)
  (angle :double)
  (bkcolor :pointer))

(cffi:defcfun ("FreeImage_RotateEx" FreeImage_RotateEx) :pointer
  (dib :pointer)
  (angle :double)
  (x_shift :double)
  (y_shift :double)
  (x_origin :double)
  (y_origin :double)
  (use_mask :pointer))

(cffi:defcfun ("FreeImage_FlipHorizontal" FreeImage_FlipHorizontal) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_FlipVertical" FreeImage_FlipVertical) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_JPEGTransform" FreeImage_JPEGTransform) :pointer
  (src_file :string)
  (dst_file :string)
  (operation :int)
  (perfect :pointer))

(cffi:defcfun ("FreeImage_JPEGTransformU" FreeImage_JPEGTransformU) :pointer
  (src_file :pointer)
  (dst_file :pointer)
  (operation :int)
  (perfect :pointer))

(cffi:defcfun ("FreeImage_Rescale" FreeImage_Rescale) :pointer
  (dib :pointer)
  (dst_width :int)
  (dst_height :int)
  (filter :int))

(cffi:defcfun ("FreeImage_MakeThumbnail" FreeImage_MakeThumbnail) :pointer
  (dib :pointer)
  (max_pixel_size :int)
  (convert :pointer))

(cffi:defcfun ("FreeImage_AdjustCurve" FreeImage_AdjustCurve) :pointer
  (dib :pointer)
  (LUT :pointer)
  (channel :int))

(cffi:defcfun ("FreeImage_AdjustGamma" FreeImage_AdjustGamma) :pointer
  (dib :pointer)
  (gamma :double))

(cffi:defcfun ("FreeImage_AdjustBrightness" FreeImage_AdjustBrightness) :pointer
  (dib :pointer)
  (percentage :double))

(cffi:defcfun ("FreeImage_AdjustContrast" FreeImage_AdjustContrast) :pointer
  (dib :pointer)
  (percentage :double))

(cffi:defcfun ("FreeImage_Invert" FreeImage_Invert) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_GetHistogram" FreeImage_GetHistogram) :pointer
  (dib :pointer)
  (histo :pointer)
  (channel :int))

(cffi:defcfun ("FreeImage_GetAdjustColorsLookupTable" FreeImage_GetAdjustColorsLookupTable) :int
  (LUT :pointer)
  (brightness :double)
  (contrast :double)
  (gamma :double)
  (invert :pointer))

(cffi:defcfun ("FreeImage_AdjustColors" FreeImage_AdjustColors) :pointer
  (dib :pointer)
  (brightness :double)
  (contrast :double)
  (gamma :double)
  (invert :pointer))

(cffi:defcfun ("FreeImage_ApplyColorMapping" FreeImage_ApplyColorMapping) :unsigned-int
  (dib :pointer)
  (srccolors :pointer)
  (dstcolors :pointer)
  (count :unsigned-int)
  (ignore_alpha :pointer)
  (swap :pointer))

(cffi:defcfun ("FreeImage_SwapColors" FreeImage_SwapColors) :unsigned-int
  (dib :pointer)
  (color_a :pointer)
  (color_b :pointer)
  (ignore_alpha :pointer))

(cffi:defcfun ("FreeImage_ApplyPaletteIndexMapping" FreeImage_ApplyPaletteIndexMapping) :unsigned-int
  (dib :pointer)
  (srcindices :pointer)
  (dstindices :pointer)
  (count :unsigned-int)
  (swap :pointer))

(cffi:defcfun ("FreeImage_SwapPaletteIndices" FreeImage_SwapPaletteIndices) :unsigned-int
  (dib :pointer)
  (index_a :pointer)
  (index_b :pointer))

(cffi:defcfun ("FreeImage_GetChannel" FreeImage_GetChannel) :pointer
  (dib :pointer)
  (channel :int))

(cffi:defcfun ("FreeImage_SetChannel" FreeImage_SetChannel) :pointer
  (dib :pointer)
  (dib8 :pointer)
  (channel :int))

(cffi:defcfun ("FreeImage_GetComplexChannel" FreeImage_GetComplexChannel) :pointer
  (src :pointer)
  (channel :int))

(cffi:defcfun ("FreeImage_SetComplexChannel" FreeImage_SetComplexChannel) :pointer
  (dst :pointer)
  (src :pointer)
  (channel :int))

(cffi:defcfun ("FreeImage_Copy" FreeImage_Copy) :pointer
  (dib :pointer)
  (left :int)
  (top :int)
  (right :int)
  (bottom :int))

(cffi:defcfun ("FreeImage_Paste" FreeImage_Paste) :pointer
  (dst :pointer)
  (src :pointer)
  (left :int)
  (top :int)
  (alpha :int))

(cffi:defcfun ("FreeImage_Composite" FreeImage_Composite) :pointer
  (fg :pointer)
  (useFileBkg :pointer)
  (appBkColor :pointer)
  (bg :pointer))

(cffi:defcfun ("FreeImage_JPEGCrop" FreeImage_JPEGCrop) :pointer
  (src_file :string)
  (dst_file :string)
  (left :int)
  (top :int)
  (right :int)
  (bottom :int))

(cffi:defcfun ("FreeImage_JPEGCropU" FreeImage_JPEGCropU) :pointer
  (src_file :pointer)
  (dst_file :pointer)
  (left :int)
  (top :int)
  (right :int)
  (bottom :int))

(cffi:defcfun ("FreeImage_PreMultiplyWithAlpha" FreeImage_PreMultiplyWithAlpha) :pointer
  (dib :pointer))

(cffi:defcfun ("FreeImage_FillBackground" FreeImage_FillBackground) :pointer
  (dib :pointer)
  (color :pointer)
  (options :int))

(cffi:defcfun ("FreeImage_EnlargeCanvas" FreeImage_EnlargeCanvas) :pointer
  (src :pointer)
  (left :int)
  (top :int)
  (right :int)
  (bottom :int)
  (color :pointer)
  (options :int))

(cffi:defcfun ("FreeImage_AllocateEx" FreeImage_AllocateEx) :pointer
  (width :int)
  (height :int)
  (bpp :int)
  (color :pointer)
  (options :int)
  (palette :pointer)
  (red_mask :unsigned-int)
  (green_mask :unsigned-int)
  (blue_mask :unsigned-int))

(cffi:defcfun ("FreeImage_AllocateExT" FreeImage_AllocateExT) :pointer
  (type :int)
  (width :int)
  (height :int)
  (bpp :int)
  (color :pointer)
  (options :int)
  (palette :pointer)
  (red_mask :unsigned-int)
  (green_mask :unsigned-int)
  (blue_mask :unsigned-int))

(cffi:defcfun ("FreeImage_MultigridPoissonSolver" FreeImage_MultigridPoissonSolver) :pointer
  (Laplacian :pointer)
  (ncycle :int))


