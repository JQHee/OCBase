//
//  ReadMe.h
//  OCBase
//
//  Created by midland on 2018/12/5.
//  Copyright © 2018年 HJQ. All rights reserved.
//
#import "log4cplus.h"

static const char *ModuleName = "XDXTestVC";
log4cplus_info("XDX_LOG", "%s - The web view address is %s",ModuleName, "");
log4cplus_error("XDX_LOG", "Refresh webview error, current URL is NULL !");
log4cplus_info("XDX_LOG", "%s - %s receive the message name is %s, message content is %s.", ModuleName, __func__,"", "");
log4cplus_debug("XDX_LOG", "%s - %s : Current URL is %s",ModuleName, __func__, "");
