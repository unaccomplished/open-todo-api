Swagger::Docs::Config.register_apis({
  "1.0" => {
    # the extension used for the API
    :api_extension_type => :json,
    # the output location where your .json files are written to
    :api_file_path => "public/api/v1",
    #the URL base path to your api
    # :base_path => "http://localhost:3000/",
    # :base_path => "https://still-headland-51006.herokuapp.com/"
    # if you want to delete all .json files at each generation
    :clean_directory => false,
    # Ability to setup base controller for each api version.  Api::V1::SomeController for example.
    # :parent_controller => ApiController,
    #The base controller class your project uses; it or its subclasses will be where you call swagger_controller and swagger_api. An array of base controller classes may be provided.
    :base_api_controller => ApiController,
    # specifies which formatting method to apply to the JSON that is written.  Options: :none, :pretty.
    :formatting => :pretty,
    # add custom attributes to api-docs
    :attributes => {
      :info => {
        "title" => "Open Todo API",
        "description" => "An externally usable API for basic to-do list application.",
        # "termsOfServiceUrl" => "http://helloreverb.com/terms/",
        "contact" => "hsu.joce@gmail.com",
        # "license" => "Apache 2.0",
        # "licenseUrl" => "http://www.apache.org/licenses/LICENSE-2.0.html"
      }
    }
  }
})
