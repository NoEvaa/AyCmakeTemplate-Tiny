#pragma once

#if defined(_WIN32) && !defined(__GNUC__)
    #define AY_API __declspec(dllexport)
#else
    #define AY_API
#endif

namespace iin {
AY_API int  ayAdd(int, int);
AY_API bool ayAdd(bool, bool);
}
