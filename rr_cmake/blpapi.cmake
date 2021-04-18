include(${CMAKE_CURRENT_LIST_DIR}/fetch_cache_archive.cmake)

function (find_blpapi)

    if (WIN32)
        set(blpapi_archive "blpapi_cpp_3.16.1.1-windows.zip")
    else ()
        set(blpapi_archive "blpapi_cpp_3.16.1.1-linux.tar.gz")
    endif()
    fetch_cache_archive(blpapi ${blpapi_archive} "https://bcms.bloomberg.com/BLPAPI-Generic/" blpapi_srcdir)

    message("find_package(blpapi PATHS ${blpapi_srcdir}/cmake REQUIRED")
    find_package(blpapi PATHS "${blpapi_srcdir}/cmake" REQUIRED)

    if (MSVC)
        set(toto blpapi)
    else () # linux cmake .so relative path problem
        get_property(toto TARGET blpapi PROPERTY IMPORTED_LOCATION)
    endif()

    set(blpapi_target ${toto} PARENT_SCOPE)

endfunction()