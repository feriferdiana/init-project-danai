package com.adiwisista.danai.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.enterprise.context.RequestScoped;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.Map;

@Path("echo")
@RequestScoped
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class EchoController {

    private static final Logger LOG = LoggerFactory.getLogger(EchoController.class);

    @GET
    public Response echo(){
        LOG.info("echo");
        return Response
                .ok()
                .entity(
                        Map.of("test", "ok")
                )
                .build();
    }
}
