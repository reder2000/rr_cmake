# install pkg_name from vcpkg

function(vcpkg_install vcpkg_name)
    if (NOT DEFINED CMAKE_TOOLCHAIN_FILE)
        message(FATAL_ERROR "package not found and no CMAKE_TOOLCHAIN_FILE")
    else ()
        cmake_path(SET vcpkg_exe NORMALIZE "${CMAKE_TOOLCHAIN_FILE}/../../../vcpkg")
        if (WIN32)
            set (vcpkg_exe "${vcpkg_exe}.exe")
        endif()
        message("COMMAND ${vcpkg_exe} install ${vcpkg_name}")
        execute_process(COMMAND "${vcpkg_exe}" "install" "${vcpkg_name}" RESULT_VARIABLE res)
        if (NOT ${res} EQUAL 0)
            message(FATAL_ERROR "vcpkg failed with result ${res}")
        endif()
    endif()
endfunction()

# find and install if necessary pkg_name from vcpkg
# an optional argument can be passed to specify the package name
# when it is not the same as the include name

function(find_vcpkg_install_missing pkg_name) 
    find_package(${pkg_name} CONFIG QUIET)
    if (${${pkg_name}_FOUND})
        message("find_vcpkg_install_missing ${pkg_name} found")
    else ()
        if (NOT DEFINED CMAKE_TOOLCHAIN_FILE)
            message(FATAL_ERROR "package not found and no CMAKE_TOOLCHAIN_FILE")
        else ()
            if ("${ARGV1}" STREQUAL "")
                set (vcpkg_name ${pkg_name})
            else ()
                set (vcpkg_name ${ARGV1})
            endif ()
			vcpkg_install(${vcpkg_name})
            find_package(${pkg_name} CONFIG REQUIRED)
        endif()
    endif()
endfunction()

# find and install if necessary header only boost-pkg_name
# boost/test_file is looked for to test if the package is installed

function(boost_header_only_package pkg_name test_file)
    find_package(Boost)
    if(Boost_FOUND)
      include_directories(${Boost_INCLUDE_DIRS})
      if (NOT EXISTS "${Boost_INCLUDE_DIRS}/boost/${test_file}")
        message("${Boost_INCLUDE_DIRS}/boost/${test_file}")
        vcpkg_install(boost-${pkg_name})
      endif()
    else()
      message(STATUS "Boost NOT Found !")
      vcpkg_install(boost-${pkg_name})
      find_package(Boost)
      include_directories(${Boost_INCLUDE_DIRS})
    endif(Boost_FOUND)
endfunction()