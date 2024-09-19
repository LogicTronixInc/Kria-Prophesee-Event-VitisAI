project(metavision_sdk_get_started)

cmake_minimum_required(VERSION 3.5)

set(CMAKE_CXX_STANDARD 17)

find_package(MetavisionSDK COMPONENTS core driver ui REQUIRED)
find_package(Boost COMPONENTS program_options)

find_package( OpenCV REQUIRED )
if(NOT OpenCV_FOUND)
  message(STATUS "cannot find OpenCV.cmake fallback to pkg-config")
endif(NOT OpenCV_FOUND)

find_package(glog REQUIRED)
if(NOT glog_FOUND)
  message(STATUS "cannot find glogConfig.cmake fallback to pkg-config")
endif(NOT glog_FOUND)

find_package(unilog REQUIRED)
find_package(xir REQUIRED)
find_package(Threads REQUIRED)

find_package(vart REQUIRED)
if(NOT vart_FOUND)
  message(STATUS "cannot find vartConfig.cmake fallback to pkg-config")
endif(NOT vart_FOUND)

include_directories(
  ./
  /usr/include/xrt
  )
set (sample metavision_histo_viewer)
add_executable(${sample} ${sample}.cpp cd_histo_frame_generator.cpp periodic_histo_frame_generation_algorithm.cpp common.cpp)
target_link_libraries(${sample} xrt_coreutil xrt_core MetavisionSDK::core MetavisionSDK::driver MetavisionSDK::ui ${OpenCV_LIBS} glog xir Threads::Threads vart-runner Boost::program_options) 
