package com.fzu.inventory_assistant.utils;

import com.fzu.inventory_assistant.utils.BizException.BizException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
@Slf4j
public class BizExceptionHandler {

//    @ExceptionHandler
//    public R normalHandle(Exception e){
////        log.error(e.getStackTrace().toString());
//        log.error(e.toString());
//        return R.error(400,"非业务错误,请联系管理员");
//    }
    @ExceptionHandler
    public R bizHandle(BizException e){
        return R.error(e.getErrorCode().getCode(),e.getMessage());
    }
}
