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

# Utility rule file for partitiondevicestest_autogen.

# Include any custom commands dependencies for this target.
include src/modules/partition/tests/CMakeFiles/partitiondevicestest_autogen.dir/compiler_depend.make

# Include the progress variables for this target.
include src/modules/partition/tests/CMakeFiles/partitiondevicestest_autogen.dir/progress.make

src/modules/partition/tests/CMakeFiles/partitiondevicestest_autogen:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Automatic MOC for target partitiondevicestest"
	cd /home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/build/src/modules/partition/tests && /usr/bin/cmake -E cmake_autogen /home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/build/src/modules/partition/tests/CMakeFiles/partitiondevicestest_autogen.dir/AutogenInfo.json Release

partitiondevicestest_autogen: src/modules/partition/tests/CMakeFiles/partitiondevicestest_autogen
partitiondevicestest_autogen: src/modules/partition/tests/CMakeFiles/partitiondevicestest_autogen.dir/build.make
.PHONY : partitiondevicestest_autogen

# Rule to build all files generated by this target.
src/modules/partition/tests/CMakeFiles/partitiondevicestest_autogen.dir/build: partitiondevicestest_autogen
.PHONY : src/modules/partition/tests/CMakeFiles/partitiondevicestest_autogen.dir/build

src/modules/partition/tests/CMakeFiles/partitiondevicestest_autogen.dir/clean:
	cd /home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/build/src/modules/partition/tests && $(CMAKE_COMMAND) -P CMakeFiles/partitiondevicestest_autogen.dir/cmake_clean.cmake
.PHONY : src/modules/partition/tests/CMakeFiles/partitiondevicestest_autogen.dir/clean

src/modules/partition/tests/CMakeFiles/partitiondevicestest_autogen.dir/depend:
	cd /home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61 /home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/modules/partition/tests /home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/build /home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/build/src/modules/partition/tests /home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/build/src/modules/partition/tests/CMakeFiles/partitiondevicestest_autogen.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/modules/partition/tests/CMakeFiles/partitiondevicestest_autogen.dir/depend

