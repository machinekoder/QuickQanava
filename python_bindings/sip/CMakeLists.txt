# Build file for Python bindings via sip and pyqt.

find_package( PythonInterp REQUIRED )
#message(${PYTHON_EXECUTABLE})

execute_process(
  COMMAND "${PYTHON_EXECUTABLE}" -c "if True:
    from distutils import sysconfig as sc
    print(sc.get_python_lib(prefix='', plat_specific=True))"
  OUTPUT_VARIABLE PYTHON_SITE
  OUTPUT_STRIP_TRAILING_WHITESPACE)

if (NOT PYTHON_SITE)
    message(FATAL_ERROR "Could not find python")
endif()

set(quickqanava_HDRS_DIR ${PROJECT_SOURCE_DIR}/src/)
set(SIP_BUILD_DIR ${CMAKE_CURRENT_BINARY_DIR}/quickqanava_sip)
set(SIP_SRC_DIR ${PROJECT_SOURCE_DIR}/python_bindings/sip)

set(quickqanava_sip_DEPENDENT_FILES
  quickqanava.sip
  edge.sip
  graph.sip
  )

find_package(python_qt_binding REQUIRED)
include(${python_qt_binding_EXTRAS_DIR}/sip_helper.cmake)
message(${python_qt_binding_EXTRAS_DIR})
message("includes: ${QuickQanava_INCLUDE_DIRS}")
message("${Qt5Quick_INCLUDE_DIRS}")
message(${SIP_SRC_DIR})

# maintain context for different named target
set(quickqanava_sip_INCLUDE_DIRS ${quickqanava_INCLUDE_DIRS}
    "${PROJECT_SOURCE_DIR}/src"
    "${PROJECT_SOURCE_DIR}/GTpo/src/gtpo/"
    "${PROJECT_SOURCE_DIR}/QuickContainers/include/"
    ${Qt5Quick_INCLUDE_DIRS}
    )
set(quickqanava_sip_LIBRARIES ${quickqanava_LIBRARIES} ${PROJECT_NAME} Qt5Quick QuickContainers)
set(quickqanava_sip_LIBRARY_DIRS ${quickqanava_LIBRARY_DIRS} lib)
set(quickqanava_sip_LDFLAGS_OTHER ${quickqanava_LDFLAGS_OTHER} -Wl,-rpath,\\"lib\\")

if(sip_helper_FOUND)
  list(APPEND quickqanava_BINDINGS "sip")
  set(quickqanava_BINDINGS "${quickqanava_BINDINGS}" PARENT_SCOPE)
  #set(quickqanava_sip_CXXFLAGS_OTHER "CXXFLAGS+=-std=c++14")
  build_sip_binding(quickqanava_sip quickqanava.sip
    SIP_CONFIGURE ${python_qt_binding_EXTRAS_DIR}/sip_configure.py
    SOURCE_DIR ${SIP_SRC_DIR}
    LIBRARY_DIR ${PYTHON_INSTALL_DIR}/quickqanava
    BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}
    DEPENDS ${quickqanava_sip_DEPENDENT_FILES}
    DEPENDENCIES ${PROJECT_NAME}
  )

  if(APPLE)
    set(quickqanava_sip_LIBRARY_FILE libquickqanava_sip.so)
  else()
    set(quickqanava_sip_LIBRARY_FILE libquickqanava_sip${CMAKE_SHARED_LIBRARY_SUFFIX})
  endif()
  install(DIRECTORY ${PYTHON_INSTALL_DIR}/quickqanava/
      DESTINATION ${PYTHON_SITE}/quickqanava)
#  install(FILES ${PYTHON_INSTALL_DIR}/quickqanava/${quickqanava_sip_LIBRARY_FILE}
#    DESTINATION ${PYTHON_SITE}/quickqanava)
endif()
