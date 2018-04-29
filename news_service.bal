import ballerina/http;
import ballerina/log;
import ballerina/mime;

@http:ServiceConfig { basePath: "/nview/news" }
service<http:Service> news bind { port: 9090 } {
    @http:ResourceConfig {
        methods: ["POST"],
        path: "/headlines"
    }
    headlines(endpoint caller, http:Request req) {

        var result = req.getJsonPayload();
        http:Response res = new;
        match result {
            error err => {
                res.statusCode = 500;
                res.setPayload(err.message);
            }
            json value => {
                res.setJsonPayload(value);
            }
        }
        caller->respond(res) but {
            error e => log:printError("Error in responding", err = e)
        };
    }
}
