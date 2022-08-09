include(FetchContent)

function (git_include package_name git_repository ) # optional include_dir
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
