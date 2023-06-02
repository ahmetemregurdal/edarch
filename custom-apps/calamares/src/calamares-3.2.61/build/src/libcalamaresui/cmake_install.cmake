# Install script for directory: /home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "0")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/sbin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "CALAMARES" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libcalamaresui.so.-1" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libcalamaresui.so.-1")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libcalamaresui.so.-1"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/build/libcalamaresui.so.-1")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libcalamaresui.so.-1" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libcalamaresui.so.-1")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libcalamaresui.so.-1"
         OLD_RPATH "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/build:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/sbin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libcalamaresui.so.-1")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "CALAMARES" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libcalamaresui.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libcalamaresui.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libcalamaresui.so"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/build/libcalamaresui.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libcalamaresui.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libcalamaresui.so")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libcalamaresui.so"
         OLD_RPATH "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/build:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/sbin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libcalamaresui.so")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "CALAMARES" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/libcalamares" TYPE FILE FILES
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/Branding.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/ViewManager.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "CALAMARES" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/libcalamares/modulesystem" TYPE FILE FILES
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/modulesystem/CppJobModule.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/modulesystem/ModuleFactory.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/modulesystem/ModuleManager.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/modulesystem/ProcessJobModule.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/modulesystem/PythonJobModule.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/modulesystem/PythonQtViewModule.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/modulesystem/ViewModule.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "CALAMARES" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/libcalamares/utils" TYPE FILE FILES
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/utils/CalamaresUtilsGui.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/utils/ImageRegistry.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/utils/Paste.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/utils/PythonQtUtils.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/utils/Qml.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/utils/QtCompat.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "CALAMARES" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/libcalamares/viewpages" TYPE FILE FILES
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/viewpages/BlankViewStep.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/viewpages/ExecutionViewStep.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/viewpages/PythonQtGlobalStorageWrapper.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/viewpages/PythonQtJob.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/viewpages/PythonQtUtilsWrapper.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/viewpages/PythonQtViewStep.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/viewpages/QmlViewStep.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/viewpages/Slideshow.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/viewpages/ViewStep.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "CALAMARES" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/libcalamares/widgets" TYPE FILE FILES
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/widgets/ClickableLabel.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/widgets/ErrorDialog.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/widgets/FixedAspectRatioLabel.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/widgets/LogWidget.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/widgets/PrettyRadioButton.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/widgets/TranslationFix.h"
    "/home/ahmetemre/git/archinstall/custom-apps/calamares/src/calamares-3.2.61/src/libcalamaresui/widgets/WaitingWidget.h"
    )
endif()

