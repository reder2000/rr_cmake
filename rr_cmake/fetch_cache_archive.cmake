include(${CMAKE_CURRENT_LIST_DIR}/get_temp.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/extract_archive.cmake)

function (fetch_cache_archive libname archive_name url_prefix result_srcdir)

    get_temp_path(tmp_path)

    IF (NOT EXISTS "${tmp_path}/${archive_name}")
        message("downloading ${archive_name}")
        set(url_blpapi "${url_prefix}/${archive_name}")
        file(DOWNLOAD ${url_blpapi} "${tmp_path}/${archive_name}")
    ELSE ()
        message("no need to download ${archive_name}")
    ENDIF()

    SET(dst_dir "${CMAKE_BINARY_DIR}/_deps/${libname}-src")

    IF (NOT EXISTS "${dst_dir}")
        message("extractring ${archive_name} to ${dst_dir}")
        extract_archive_remove_level_one("${dst_dir}" "${tmp_path}/${archive_name}")


    #    message("blpapi_srcdir ${blpapi_srcdir}")#$

    #    include(ExternalProject)
    #    ExternalProject_Add(blpapi_dowloaded
    #    CONFIGURE_COMMAND ""
    #    BUILD_COMMAND ""
    #    SOURCE_DIR ${blpapi_srcdir}
    #    EXCLUDE_FROM_ALL TRUE
    #    )

    SET(${result_srcdir} ${dst_dir} PARENT_SCOPE)

    ENDIF()


endfunction()
