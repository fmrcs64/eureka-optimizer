# - Find VTune jitprofiling.
# Defines:
# VTune_FOUND
# VTune_INCLUDE_DIRS
# VTune_LIBRARIES
set(dirs
  # Intel oneAPI (2021+)
  "$ENV{VTUNE_PROFILER_DIR}/"
  "C:/Program Files (x86)/Intel/oneAPI/vtune/latest/"
  # "/opt/intel/oneapi/vtune/latest/" Linux

  # VTune Amplifier 2020
  "$ENV{VTUNE_AMPLIFIER_2020_DIR}/"
  "C:/Program Files (x86)/Intel/VTune Amplifier 2020/"

  # VTune Amplifier 2019
  "$ENV{VTUNE_AMPLIFIER_2019_DIR}/"
  "C:/Program Files (x86)/Intel/VTune Amplifier 2019/"

  # VTune Amplifier 2018
  "$ENV{VTUNE_AMPLIFIER_2018_DIR}/"
  "C:/Program Files (x86)/Intel/VTune Amplifier 2018/"

  # VTune Amplifier XE 2016
  "$ENV{VTUNE_AMPLIFIER_XE_2016_DIR}/"
  "C:/Program Files (x86)/Intel/VTune Amplifier XE 2016/"

  # VTune Amplifier XE 2015
  "$ENV{VTUNE_AMPLIFIER_XE_2015_DIR}/"
  "C:/Program Files (x86)/Intel/VTune Amplifier XE 2015/"

  # VTune Amplifier XE 2013 (original)
  "$ENV{VTUNE_AMPLIFIER_XE_2013_DIR}/"
  "C:/Program Files (x86)/Intel/VTune Amplifier XE 2013/"

  # VTune Amplifier XE 2011 (original)
  "$ENV{VTUNE_AMPLIFIER_XE_2011_DIR}/"
  "C:/Program Files (x86)/Intel/VTune Amplifier XE 2011/"
  )

find_path(VTune_INCLUDE_DIRS jitprofiling.h
    PATHS ${dirs}
    PATH_SUFFIXES include)

if (CMAKE_SIZEOF_VOID_P MATCHES "8")
  set(vtune_lib_dir lib64)
else()
  set(vtune_lib_dir lib32)
endif()

find_library(VTUNE_JITPROFILING_LIB
    NAMES jitprofiling
    HINTS "${VTune_INCLUDE_DIRS}/.."
    PATHS ${dirs}
    PATH_SUFFIXES ${vtune_lib_dir})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    VTune DEFAULT_MSG VTUNE_JITPROFILING_LIB VTune_INCLUDE_DIRS)
