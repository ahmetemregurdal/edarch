# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.26

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/build

# Utility rule file for show-version.

# Include any custom commands dependencies for this target.
include CMakeFiles/show-version.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/show-version.dir/progress.make

CMakeFiles/show-version:
	/usr/bin/cmake -E echo CALAMARES_VERSION=-1

show-version: CMakeFiles/show-version
show-version: CMakeFiles/show-version.dir/build.make
.PHONY : show-version

# Rule to build all files generated by this target.
CMakeFiles/show-version.dir/build: show-version
.PHONY : CMakeFiles/show-version.dir/build

CMakeFiles/show-version.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/show-version.dir/cmake_clean.cmake
.PHONY : CMakeFiles/show-version.dir/clean

CMakeFiles/show-version.dir/depend:
	cd /home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61 /home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61 /home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/build /home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/build /home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/build/CMakeFiles/show-version.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/show-version.dir/depend

