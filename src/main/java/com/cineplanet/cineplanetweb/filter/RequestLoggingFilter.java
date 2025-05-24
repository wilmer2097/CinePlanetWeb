// src/main/java/com/cineplanet/cineplanetweb/filter/RequestLoggingFilter.java
package com.cineplanet.cineplanetweb.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@WebFilter("/*")
public class RequestLoggingFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest http = (HttpServletRequest) req;
        System.out.println("🔍 RequestFilter → "
            + http.getMethod() + " " + http.getRequestURI());
        chain.doFilter(req, res);
    }
}
