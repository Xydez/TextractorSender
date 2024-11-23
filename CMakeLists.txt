cmake_minimum_required(VERSION 3.24 FATAL_ERROR)

# Projects
project(TextractorSender LANGUAGES CXX)

if(MSVC)
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
endif()

# Dependencies
# - nlohmann-json
find_package(nlohmann_json CONFIG REQUIRED)
# - libuv
find_package(libuv CONFIG REQUIRED)
# - zlib
find_package(ZLIB)
# - usockets
find_path(USOCKETS_INCLUDE_DIRS "libusockets.h")
find_library(USOCKETS_LIB "uSockets")
# - uwebsockets
find_path(UWEBSOCKETS_INCLUDE_DIRS "uwebsockets/App.h")

set(CMAKE_CXX_STANDARD 23)

file(GLOB SOURCE_FILES
    "TextractorSender/**/*.cpp"
	"TextractorSender/*.cpp"
	"TextractorSender/*.h"
)

# Targets
add_library(TextractorSender SHARED ${SOURCE_FILES})

if(MSVC)
    set(VS_IGNORE_MTD_LIBRARY_FLAGS "/NODEFAULTLIB:LIBCMTD.lib")

    # Ignore LIBCMTD.lib for "Release", "MinSizeRel" and "RelWithDebInfo"
	# Source: https://cmake.cmake.narkive.com/psL87gPe/ignoring-a-specific-library
    set_target_properties(TextractorSender PROPERTIES
	    LINK_FLAGS_RELEASE
		${VS_IGNORE_MTD_LIBRARY_FLAGS})
	set_target_properties(TextractorSender PROPERTIES
		LINK_FLAGS_MINSIZEREL
		${VS_IGNORE_MTD_LIBRARY_FLAGS})
	set_target_properties(TextractorSender PROPERTIES
		LINK_FLAGS_RELWITHDEBINFO
		${VS_IGNORE_MTD_LIBRARY_FLAGS})
endif()

target_link_libraries(TextractorSender
	PRIVATE nlohmann_json::nlohmann_json
    PRIVATE $<IF:$<TARGET_EXISTS:libuv::uv_a>,libuv::uv_a,libuv::uv>
	PRIVATE ZLIB::ZLIB
	PRIVATE ${USOCKETS_LIB}
)

target_include_directories(TextractorSender
	PRIVATE ${UWEBSOCKETS_INCLUDE_DIRS}
)