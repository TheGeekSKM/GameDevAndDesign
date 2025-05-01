#include <cstdlib>
#ifdef _WIN32 /* Windows */
#include <windows.h>
#define EXPORTED_FUNCTION extern "C" __declspec(dllexport)
#else /* Linux, FreeBSD, DragonFly BSD, NetBSD, OpenBSD, SunOS */
#include <X11/Xlib.h>
#define EXPORTED_FUNCTION extern "C" __attribute__((visibility("default")))
#endif

EXPORTED_FUNCTION void SetOwnerWindowId(char *window, char *owner) {
  #ifdef _WIN32
  SetWindowLongPtrW((HWND)(void *)strtoull(window, nullptr, 10), GWLP_HWNDPARENT, (LONG_PTR)(HWND)(void *)strtoull(owner, nullptr, 10));
  #else
  Display *disp = XOpenDisplay(nullptr);
  XSetTransientForHint(disp, (Window)strtoul(window, nullptr, 10), (Window)strtoul(owner, nullptr, 10));
  XCloseDisplay(disp);
  #endif
}
