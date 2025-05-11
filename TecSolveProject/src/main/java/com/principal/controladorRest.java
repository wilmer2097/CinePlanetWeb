package com.principal;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
@Slf4j
public class controladorRest {
    @GetMapping("/")
    public String comienzo() {
        log.info("Primera sentencia");
        return "principal";
    }
}
