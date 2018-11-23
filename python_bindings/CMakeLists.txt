set(quickqanava_BINDINGS "")

find_package(python_qt_binding PATHS ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

if (python_qt_binding_FOUND)

  set(PYTHON_INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/python_install)
  set(PACKAGE_PYTHON_DESTINATION ${PROJECT_SOURCE_DIR}/build/python)

  # add_subdirectory(shiboken)
  add_subdirectory(sip)

  message("Python binding generators: ${quickqanava_BINDINGS}")
  if(NOT quickqanava_BINDINGS)
    message(FATAL_ERROR "No Python binding generator found.")
  endif()

  install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/quickqanava/__init__.py
      DESTINATION ${PYTHON_INSTALL_DIR}/quickqanava)

endif()
