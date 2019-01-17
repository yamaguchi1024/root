set(root_build_options)

#---------------------------------------------------------------------------------------------------
#---ROOT_BUILD_OPTION( name defvalue [description] )
#---------------------------------------------------------------------------------------------------
function(ROOT_BUILD_OPTION opt defvalue)
  if(ARGN)
    set(description ${ARGN})
  else()
    set(description " ")
  endif()
  set(${opt}_defvalue    ${defvalue} PARENT_SCOPE)
  set(${opt}_description ${description} PARENT_SCOPE)
  set(root_build_options  ${root_build_options} ${opt} PARENT_SCOPE )
endfunction()

#---------------------------------------------------------------------------------------------------
#---ROOT_APPLY_OPTIONS()
#---------------------------------------------------------------------------------------------------
function(ROOT_APPLY_OPTIONS)
  foreach(opt ${root_build_options})
     option(${opt} "${${opt}_description}" ${${opt}_defvalue})
  endforeach()  
endfunction()

#---------------------------------------------------------------------------------------------------
#---ROOT_GET_OPTIONS(result ENABLED)
#---------------------------------------------------------------------------------------------------
function(ROOT_GET_OPTIONS result)
  CMAKE_PARSE_ARGUMENTS(ARG "ENABLED" "" "" ${ARGN})
  set(enabled)
  foreach(opt ${root_build_options})
    if(ARG_ENABLED)
      if(${opt})
        set(enabled "${enabled} ${opt}")
      endif()
    else()
      set(enabled "${enabled} ${opt}")
    endif()
  endforeach()
  set(${result} "${enabled}" PARENT_SCOPE)
endfunction()

#---------------------------------------------------------------------------------------------------
#---ROOT_SHOW_ENABLED_OPTIONS()
#---------------------------------------------------------------------------------------------------
function(ROOT_SHOW_ENABLED_OPTIONS)
  set(enabled_opts)
  ROOT_GET_OPTIONS(enabled_opts ENABLED)
  foreach(opt ${enabled_opts})
    message(STATUS "Enabled support for: ${opt}")
  endforeach()
endfunction()

#---------------------------------------------------------------------------------------------------
#---ROOT_WRITE_OPTIONS(file )
#---------------------------------------------------------------------------------------------------
function(ROOT_WRITE_OPTIONS file)
  file(WRITE ${file} "#---Options enabled for the build of ROOT-----------------------------------------------\n")
  foreach(opt ${root_build_options})
    if(${opt})
      file(APPEND ${file} "set(${opt} ON)\n")
    else()
      file(APPEND ${file} "set(${opt} OFF)\n")
    endif()
  endforeach()
endfunction()

#--------------------------------------------------------------------------------------------------
#---Full list of options with their descriptions and default values
#   The default value can be changed as many times as we wish before calling ROOT_APPLY_OPTIONS()
#--------------------------------------------------------------------------------------------------

ROOT_BUILD_OPTION(alien OFF "Enable support for AliEn (requires libgapiUI from ALICE)")
ROOT_BUILD_OPTION(arrow OFF "Enable support for Apache Arrow")
ROOT_BUILD_OPTION(asimage ON "Enable support for image processing via libAfterImage")
ROOT_BUILD_OPTION(astiff ON "Enable support for TIFF images via libAfterImage")
ROOT_BUILD_OPTION(builtin_afterimage ON "Build bundled copy of libAfterImage")
ROOT_BUILD_OPTION(builtin_cfitsio OFF "Build CFITSIO internally (requires network)")
ROOT_BUILD_OPTION(builtin_clang ON "Build bundled copy of Clang")
ROOT_BUILD_OPTION(builtin_davix OFF "Build Davix internally (requires network)")
ROOT_BUILD_OPTION(builtin_fftw3 OFF "Build FFTW3 internally (requires network)")
ROOT_BUILD_OPTION(builtin_freetype OFF "Build bundled copy of freetype")
ROOT_BUILD_OPTION(builtin_ftgl ON "Build bundled copy of FTGL")
ROOT_BUILD_OPTION(builtin_gl2ps OFF "Build bundled copy of gl2ps")
ROOT_BUILD_OPTION(builtin_glew ON "Build bundled copy of GLEW")
ROOT_BUILD_OPTION(builtin_gsl OFF "Build GSL internally (requires network)")
ROOT_BUILD_OPTION(builtin_llvm ON "Build bundled copy of LLVM")
ROOT_BUILD_OPTION(builtin_lz4 OFF "Build bundled copy of lz4")
ROOT_BUILD_OPTION(builtin_lzma OFF "Build bundled copy of lzma")
ROOT_BUILD_OPTION(builtin_openssl OFF "Build OpenSSL internally (requires network)")
ROOT_BUILD_OPTION(builtin_pcre OFF "Build bundled copy of PCRE")
ROOT_BUILD_OPTION(builtin_tbb OFF "Build TBB internally (requires network)")
ROOT_BUILD_OPTION(builtin_unuran OFF "Build bundled copy of unuran")
ROOT_BUILD_OPTION(builtin_vc OFF "Build Vc internally (requires network)")
ROOT_BUILD_OPTION(builtin_vdt OFF "Build VDT internally (requires network)")
ROOT_BUILD_OPTION(builtin_veccore OFF "Build VecCore internally (requires network)")
ROOT_BUILD_OPTION(builtin_xrootd OFF "Build XRootD internally (requires network)")
ROOT_BUILD_OPTION(builtin_xxhash OFF "Build bundled copy of xxHash")
ROOT_BUILD_OPTION(builtin_zlib OFF "Build bundled copy of zlib")
ROOT_BUILD_OPTION(ccache OFF "Enable ccache usage for speeding up builds")
ROOT_BUILD_OPTION(cefweb OFF "Enable support for CEF (Chromium Embedded Framework) web-based display")
ROOT_BUILD_OPTION(clad ON "Build clad, the cling automatic differentiation plugin")
ROOT_BUILD_OPTION(cling ON "Enable new CLING C++ interpreter")
ROOT_BUILD_OPTION(cocoa OFF "Use native Cocoa/Quartz graphics backend (MacOS X only)")
ROOT_BUILD_OPTION(coverage OFF "Enable compile flags for coverage testing")
ROOT_BUILD_OPTION(cuda OFF "Enable support for CUDA (requires CUDA toolkit >= 7.5)")
ROOT_BUILD_OPTION(cxxmodules OFF "Enable support for C++ modules")
ROOT_BUILD_OPTION(davix ON "Enable support for Davix (HTTP/WebDAV access)")
ROOT_BUILD_OPTION(dcache OFF "Enable support for dCache (requires libdcap from DESY)")
ROOT_BUILD_OPTION(exceptions ON "Enable compiler exception handling")
ROOT_BUILD_OPTION(explicitlink ON "Explicitly link with all dependent libraries")
ROOT_BUILD_OPTION(fftw3 ON "Enable support for FFTW3")
ROOT_BUILD_OPTION(fitsio ON "Enable support for reading FITS images")
ROOT_BUILD_OPTION(fortran OFF "Build Fortran components of ROOT")
ROOT_BUILD_OPTION(gdml ON "Enable support for GDML (Geometry Description Markup Language)")
ROOT_BUILD_OPTION(gfal ON "Enable support for GFAL (Grid File Access Library)")
ROOT_BUILD_OPTION(gnuinstall OFF "Perform installation following the GNU guidelines")
ROOT_BUILD_OPTION(gsl_shared OFF "Enable linking against shared libraries for GSL (default no)")
ROOT_BUILD_OPTION(http ON "Enable suppport for HTTP server")
ROOT_BUILD_OPTION(imt ON "Enable support for implicit multi-threading via Intel® Thread Bulding Blocks (TBB)")
ROOT_BUILD_OPTION(jemalloc OFF "Use jemalloc memory allocator")
ROOT_BUILD_OPTION(krb5 OFF "Enable support for Kerberos")
ROOT_BUILD_OPTION(ldap OFF "Enable support for LDAP (Lightweight Directory Access Protocol)")
ROOT_BUILD_OPTION(libcxx OFF "Build using libc++")
ROOT_BUILD_OPTION(macos_native OFF "Disable looking for libraries, includes and binaries in locations other than a native installation (MacOS only)")
ROOT_BUILD_OPTION(mathmore ON "Build libMathMore extended math library (requires GSL)")
ROOT_BUILD_OPTION(memory_termination OFF "Free internal ROOT memory before process termination (experimental, used for leak checking)")
ROOT_BUILD_OPTION(memstat OFF "Build memory statistics utility (helps to detect memory leaks)")
ROOT_BUILD_OPTION(minuit2 OFF "Build Minuit2 minimization library")
ROOT_BUILD_OPTION(monalisa OFF "Enable support for monitoring with Monalisa (requires libapmoncpp)")
ROOT_BUILD_OPTION(mysql ON "Enable support for MySQL databases")
ROOT_BUILD_OPTION(odbc OFF "Enable support for ODBC databases (requires libiodbc or libodbc)")
ROOT_BUILD_OPTION(opengl ON "Enable support for OpenGL (requires libGL and libGLU)")
ROOT_BUILD_OPTION(oracle ON "Enable support for Oracle databases (requires Oracle Instant Client)")
ROOT_BUILD_OPTION(pch ON "Enable support for Pre-Compiled Headers (PCH)")
ROOT_BUILD_OPTION(pgsql ON "Enable support for PostgreSQL")
ROOT_BUILD_OPTION(pyroot_experimental OFF "Use experimental Python bindings for ROOT")
ROOT_BUILD_OPTION(pythia6_nolink OFF "Delayed linking of Pythia6 library")
ROOT_BUILD_OPTION(pythia6 ON "Enable support for Pythia 6.x")
ROOT_BUILD_OPTION(pythia8 ON "Enable support for Pythia 8.x")
ROOT_BUILD_OPTION(python ON "Enable support for automatic Python bindings (PyROOT)")
ROOT_BUILD_OPTION(qt5web OFF "Enable support for Qt5 web-based display (requires Qt5WebEngine)")
ROOT_BUILD_OPTION(r OFF "Enable support for R bindings (requires R, Rcpp, and RInside)")
ROOT_BUILD_OPTION(roofit ON "Build RooFit advanced fitting package")
ROOT_BUILD_OPTION(root7 ON "Build ROOT 7 components of ROOT (requires C++14 standard or higher)")
ROOT_BUILD_OPTION(rpath OFF "Link libraries with built-in RPATH (run-time search path)")
ROOT_BUILD_OPTION(runtime_cxxmodules OFF "Enable runtime support for C++ modules")
ROOT_BUILD_OPTION(shadowpw OFF "Enable support for shadow passwords")
ROOT_BUILD_OPTION(shared ON "Use shared 3rd party libraries if possible")
ROOT_BUILD_OPTION(soversion OFF "Set version number in sonames (recommended)")
ROOT_BUILD_OPTION(sqlite ON "Enable support for SQLite")
ROOT_BUILD_OPTION(ssl ON "Enable support for SSL encryption via OpenSSL")
ROOT_BUILD_OPTION(tcmalloc OFF "Use tcmalloc memory allocator")
ROOT_BUILD_OPTION(thread ON "Enable support for multi-threading (cannot be disabled)")
ROOT_BUILD_OPTION(tmva ON "Build TMVA multi variate analysis library")
ROOT_BUILD_OPTION(tmva-cpu ON "Build TMVA with CPU support for deep learning (requires BLAS)")
ROOT_BUILD_OPTION(tmva-gpu ON "Build TMVA with GPU support for deep learning (requries CUDA)")
ROOT_BUILD_OPTION(tmva-pymva ON "Enable support for Python in TMVA (requires numpy)")
ROOT_BUILD_OPTION(tmva-rmva OFF "Enable support for R in TMVA")
ROOT_BUILD_OPTION(unuran OFF "Enable support for UNURAN (package for generating non-uniform random numbers)")
ROOT_BUILD_OPTION(vc OFF "Enable support for Vc (SIMD Vector Classes for C++)")
ROOT_BUILD_OPTION(vdt ON "Enable support for VDT (fast and vectorisable mathematical functions)")
ROOT_BUILD_OPTION(veccore OFF "Enable support for VecCore SIMD abstraction library")
ROOT_BUILD_OPTION(vecgeom OFF "Enable support for VecGeom vectorized geometry library")
ROOT_BUILD_OPTION(winrtdebug OFF "Link against the Windows debug runtime library")
ROOT_BUILD_OPTION(x11 ON "Enable support for X11")
ROOT_BUILD_OPTION(xft ON "Enable anti-alias support with Xft")
ROOT_BUILD_OPTION(xml ON "Enable support for XML (requires libxml2)")
ROOT_BUILD_OPTION(xrootd ON "Enable support for XRootD file server and client")

option(all "Enable all optional components by default" OFF)
option(clingtest "Enable cling tests (Note: that this makes llvm/clang symbols visible in libCling)" OFF)
option(fail-on-missing "Fail at configure time if a required package cannot be found" OFF)
option(gminimal "Enable only required options by default, but include X11" OFF)
option(minimal "Enable only required options by default" OFF)
option(rootbench "Build rootbench if rootbench exists in root or if it is a sibling directory." OFF)
option(roottest "Build roottest if roottest exists in root or if it is a sibling directory." OFF)
option(testing "Enable testing with CTest" OFF)

set(gcctoolchain "" CACHE PATH "Set path to GCC toolchain used to build llvm/clang")

if (runtime_cxxmodules)
  set(pch_defvalue OFF)
endif(runtime_cxxmodules)

#--- TMVA --------------------------------------------------------------------------------------
# User can specify either old name or new name for enabling rmva
if (tmva)
  if (r OR tmva-rmva)
    set(r ON)
    set(tmva-rmva ON)
  endif()
else()
  set(tmva-cpu OFF CACHE BOOL "Disabled because tmva is disabled (${tmva-cpu_description})" FORCE)
  set(tmva-gpu OFF CACHE BOOL "Disabled because tmva is disabled (${tmva-gpu_description})" FORCE)
  set(tmva-rmva OFF CACHE BOOL "Disabled because tmva is disabled (${tmva-rmva_description})" FORCE)
  set(tmva-pymva OFF CACHE BOOL "Disabled because tmva is disabled (${tmva-pymva_description})" FORCE)
endif()


#--- Compression algorithms in ROOT-------------------------------------------------------------
set(compression_default "zlib" CACHE STRING "Default compression algorithm (zlib (default), lz4, or lzma)")
string(TOLOWER "${compression_default}" compression_default)
if("${compression_default}" MATCHES "zlib|lz4|lzma")
  message(STATUS "ROOT default compression algorithm: ${compression_default}")
else()
  message(FATAL_ERROR "Unsupported compression algorithm: ${compression_default}\n"
    "Known values are zlib, lzma, lz4 (case-insensitive).")
endif()

#--- Minor chnages in defaults due to platform--------------------------------------------------
if(WIN32)
  set(x11_defvalue OFF)
  set(memstat_defvalue OFF)
  set(davix_defvalue OFF)
  set(imt_defvalue OFF)
  set(builtin_tbb_defvalue OFF)
  set(tmva_defvalue OFF)
  set(roofit_defvalue OFF)
  set(roottest_defvalue OFF)
  set(testing_defvalue OFF)
  set(vdt_defvalue OFF)
elseif(APPLE)
  set(x11_defvalue OFF)
  set(cocoa_defvalue ON)
endif()

#--- The 'all' option swithes ON major options---------------------------------------------------
if(all)
 set(arrow_defvalue ON)
 set(dcache_defvalue ON)
 set(fitsio_defvalue ON)
 set(fortran_defvalue ON)
 set(gdml_defvalue ON)
 set(http_defvalue ON)
 set(krb5_defvalue ON)
 set(ldap_defvalue ON)
 set(memstat_defvalue ON)
 set(minuit2_defvalue ON)
 set(monalisa_defvalue ON)
 set(odbc_defvalue ON)
 set(r_defvalue ON)
 set(roofit_defvalue ON)
 set(root7_defvalue ON)
 set(shadowpw_defvalue ON)
 set(table_defvalue ON)
 set(unuran_defvalue ON)
 set(vc_defvalue ON)
 set(vdt_defvalue ON)
 set(veccore_defvalue ON)
endif()

#--- The 'builtin_all' option swithes ON old the built in options-------------------------------
if(builtin_all)
  set(builtin_afterimage_defvalue ON)
  set(builtin_cfitsio_defvalue ON)
  set(builtin_clang_defvalue ON)
  set(builtin_davix_defvalue ON)
  set(builtin_fftw3_defvalue ON)
  set(builtin_freetype_defvalue ON)
  set(builtin_ftgl_defvalue ON)
  set(builtin_gl2ps_defvalue ON)
  set(builtin_glew_defvalue ON)
  set(builtin_gsl_defvalue ON)
  set(builtin_llvm_defvalue ON)
  set(builtin_lz4_defvalue ON)
  set(builtin_lzma_defvalue ON)
  set(builtin_openssl_defvalue ON)
  set(builtin_pcre_defvalue ON)
  set(builtin_tbb_defvalue ON)
  set(builtin_unuran_defvalue ON)
  set(builtin_vc_defvalue ON)
  set(builtin_vdt_defvalue ON)
  set(builtin_veccore_defvalue ON)
  set(builtin_xrootd_defvalue ON)
  set(builtin_xxhash_defvalue ON)
  set(builtin_zlib_defvalue ON)
endif()

#---Vc supports only x86_64 architecture-------------------------------------------------------
if (NOT CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
  message(STATUS "Vc does not support ${CMAKE_SYSTEM_PROCESSOR}. Support for Vc disabled.")
  set(vc_defvalue OFF)
endif()

#---Options depending of CMake Generator-------------------------------------------------------
if( CMAKE_GENERATOR STREQUAL Ninja)
   set(fortran_defvalue OFF) 
endif()

#---Apply minimal or gminimal------------------------------------------------------------------
foreach(opt ${root_build_options})
  if(NOT opt MATCHES "thread|cling|builtin_llvm|builtin_clang|builtin_ftgl|shared|explicitlink")
    if(minimal)
      set(${opt}_defvalue OFF)
    elseif(gminimal AND NOT opt MATCHES "x11|cocoa")
      set(${opt}_defvalue OFF)
    endif()
  endif()
endforeach()

#---ROOT 7 requires C++14 standard or higher---------------------------------------------------
if (NOT FIXME_TEMPORARILY_EXCLUDED_FOR_RUNTIME_CXXMODULES)
if(CMAKE_CXX_STANDARD GREATER 11)
  set(root7_defvalue ON)
endif()
endif()

#---roottest option implies testing
if(roottest OR rootbench)
  set(testing ON CACHE BOOL "" FORCE)
endif()

#---Define at moment the options with the selected default values-----------------------------
ROOT_APPLY_OPTIONS()

#---Removed options------------------------------------------------------------
foreach(opt afdsmgrd afs bonjour castor chirp geocad glite globus gviz hdfs ios qt qtgsi rfio ruby sapdb srp table)
  if(${opt})
    message(FATAL_ERROR ">>> Option '${opt}' has been removed in ROOT v6.16.")
  endif()
endforeach()

#---Deprecated options---------------------------------------------------------
foreach(opt krb5 ldap memstat odbc)
  if(${opt})
    message(DEPRECATION ">>> Option '${opt}' is deprecated and will be removed in ROOT v6.18. Please inform rootdev@cern.ch should you still need it.")
  endif()
endforeach()

#---Avoid creating dependencies to 'non-standard' header files -------------------------------
include_regular_expression("^[^.]+$|[.]h$|[.]icc$|[.]hxx$|[.]hpp$")

#---Add Installation Variables------------------------------------------------------------------
include(RootInstallDirs)

#---RPATH options-------------------------------------------------------------------------------
#  When building, don't use the install RPATH already (but later on when installing)
set(CMAKE_SKIP_BUILD_RPATH FALSE)         # don't skip the full RPATH for the build tree
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE) # use always the build RPATH for the build tree
set(CMAKE_MACOSX_RPATH TRUE)              # use RPATH for MacOSX
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE) # point to directories outside the build tree to the install RPATH

# Check whether to add RPATH to the installation (the build tree always has the RPATH enabled)
if(rpath)
  set(CMAKE_INSTALL_RPATH ${CMAKE_INSTALL_FULL_LIBDIR}) # install LIBDIR
  set(CMAKE_SKIP_INSTALL_RPATH FALSE)          # don't skip the full RPATH for the install tree
elseif(APPLE)
  set(CMAKE_INSTALL_NAME_DIR "@rpath")
  if(gnuinstall)
    set(CMAKE_INSTALL_RPATH ${CMAKE_INSTALL_FULL_LIBDIR}) # install LIBDIR
  else()
    set(CMAKE_INSTALL_RPATH "@loader_path/../lib")    # self relative LIBDIR
  endif()
  set(CMAKE_SKIP_INSTALL_RPATH FALSE)          # don't skip the full RPATH for the install tree
else()
  set(CMAKE_SKIP_INSTALL_RPATH TRUE)           # skip the full RPATH for the install tree
endif()

#---deal with the DCMAKE_IGNORE_PATH------------------------------------------------------------
if(macos_native)
  if(APPLE)
    set(CMAKE_IGNORE_PATH)
    foreach(_prefix /sw /opt/local /usr/local) # Fink installs in /sw, and MacPort in /opt/local and Brew in /usr/local
      list(APPEND CMAKE_IGNORE_PATH ${_prefix}/bin ${_prefix}/include ${_prefix}/lib)
    endforeach()
  else()
    message(STATUS "Option 'macos_native' is only for MacOS systems. Ignoring it.")
  endif()
endif()



