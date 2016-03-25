
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := lua_extensions_static
LOCAL_MODULE_FILENAME := libluaextensions

LOCAL_SRC_FILES := $(LOCAL_PATH)/lua_extensions_more.c \
                    $(LOCAL_PATH)/zlib/lua_zlib.c \
                    $(LOCAL_PATH)/filesystem/lfs.c \
                    $(LOCAL_PATH)/lpack/lpack.c \
					$(LOCAL_PATH)/crypt/lsha1.c \
                    $(LOCAL_PATH)/crypt/lua-crypt.c \
					$(LOCAL_PATH)/pbc/alloc.c \
					$(LOCAL_PATH)/pbc/array.c \
					$(LOCAL_PATH)/pbc/bootstrap.c \
					$(LOCAL_PATH)/pbc/context.c \
					$(LOCAL_PATH)/pbc/decode.c \
					$(LOCAL_PATH)/pbc/map.c \
					$(LOCAL_PATH)/pbc/pattern.c \
					$(LOCAL_PATH)/pbc/pbc-lua.c \
					$(LOCAL_PATH)/pbc/proto.c \
					$(LOCAL_PATH)/pbc/register.c \
					$(LOCAL_PATH)/pbc/rmessage.c \
					$(LOCAL_PATH)/pbc/stringpool.c \
					$(LOCAL_PATH)/pbc/varint.c \
					$(LOCAL_PATH)/pbc/wmessage.c \


LOCAL_SRC_FILES += \
                        $(LOCAL_PATH)/cjson/fpconv.c \
                        $(LOCAL_PATH)/cjson/lua_cjson.c \
                        $(LOCAL_PATH)/cjson/strbuf.c

ifeq ($(CC_USE_SQLITE),1)
LOCAL_SRC_FILES += \
                        $(LOCAL_PATH)/lsqlite3/sqlite3.c \
                        $(LOCAL_PATH)/lsqlite3/lsqlite3.c
endif

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/ \
                           $(LOCAL_PATH)/cjson \
                           $(LOCAL_PATH)/zlib \
                           $(LOCAL_PATH)/debugger \
                           $(LOCAL_PATH)/filesystem \
                           $(LOCAL_PATH)/lpack \
                           $(LOCAL_PATH)/lsqlite3

LOCAL_C_INCLUDES := $(LOCAL_PATH)/ \
                    $(LOCAL_PATH)/cjson \
                    $(LOCAL_PATH)/zlib \
                    $(LOCAL_PATH)/debugger \
                    $(LOCAL_PATH)/filesystem \
                    $(LOCAL_PATH)/lpack \
                    $(LOCAL_PATH)/lsqlite3 \
                    $(COCOS2DX_ROOT)/cocos \
                    $(COCOS2DX_ROOT)/external/lua/luajit/include




include $(BUILD_STATIC_LIBRARY)

