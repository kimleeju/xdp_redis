#include "sds.h"
#include "server.h"
static __always_inline sds sdsmvtonvm(const sds s)
{
    if(server.nvm_base && !is_nvm_addr(s))
    {
        size_t header_size = sdsheadersize(s);
        size_t total_size = header_size + sdsalloc(s) + 1;
        if(total_size >= server.sdsmv_threshold)
        {
            void* new_sh = nvm_malloc(total_size);
            if(!new_sh)
            {
                //serverLog(LL_WARNING, "Can't allocate on NVM. Keep data in memory.");
                return s;
            }
            void* sh = s - header_size;
            size_t used_size = header_size + sdslen(s) + 1;
            pmem_memcpy_persist(new_sh, sh, used_size);
            zfree(sh);
            return (char*)new_sh + header_size;
        }
    }
    return s;
}

