include(FetchContent)

function (old_²git_include package_name git_repository ) # optional include_dir
	FetchContent_Declare(
	  ${package_name}
	  GIT_REPOSITORY ${git_repository}
	  GIT_TAG origin/master
	  GIT_REMOTE_UPDATE_STRATEGY REBASE_CHECKOUT
	  GIT_PROGRESS TRUE
	  GIT_SHALLOW TRUE
	  LOG_UPDATE TRUE
	)
	set(${package_name}_BUILD_TESTS OFF)
	FetchContent_MakeAvailable(${package_name})
	if ("${ARGV2}" STREQUAL "")
		include_directories(${${package_name}_SOURCE_DIR})
	else ()
		include_directories(${${package_name}_SOURCE_DIR}/${ARGV2})
	endif ()
	# for config
	include_directories(${${package_name}_BINARY_DIR})
endfunction()

# git_include(my_package https://mygithub/exmaple.git BRANCH dev SOURCEDIR mydir)
function(git_include package_name git_repository)
    set(prefix GI)
    #set(flags IS_ASCII IS_UNICODE)
    set(singleValues BRANCH SOURCEDIR)
    #set(multiValues SOURCES RES)

    include(CMakeParseArguments)

    cmake_parse_arguments(PARSE_ARGV 2 ${prefix}
                     "${flags}"
                     "${singleValues}"
                     "${multiValues}"
	)

	if ("${GI_BRANCH}" STREQUAL "")
	set(GI_BRANCH master)
	endif()

#    message(" GI_BRANCH: ${GI_BRANCH}")
#    message(" GI_SOURCEDIR: ${GI_SOURCEDIR}")
#    #message(" DEMO_SOURCES: ${DEMO_SOURCES}")
#    #message(" DEMO_RES: ${DEMO_RES}")

#    message(" named arg package_name : ${package_name}")
#    message(" named arg  git_repository: ${git_repository}")

		FetchContent_Declare(
	  ${package_name}
	  GIT_REPOSITORY ${git_repository}
	  GIT_TAG origin/${GI_BRANCH}
	  GIT_REMOTE_UPDATE_STRATEGY REBASE_CHECKOUT
	  GIT_PROGRESS TRUE
	  GIT_SHALLOW TRUE
	  LOG_UPDATE TRUE
	)
	set(${package_name}_BUILD_TESTS OFF)
	FetchContent_MakeAvailable(${package_name})
	if ("${GI_SOURCEDIR}" STREQUAL "")
		include_directories(${${package_name}_SOURCE_DIR})
	else ()
		include_directories(${${package_name}_SOURCE_DIR}/${GI_SOURCEDIR})
	endif ()
	# for config
	include_directories(${${package_name}_BINARY_DIR})

endfunction()