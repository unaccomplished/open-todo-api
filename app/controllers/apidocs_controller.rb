class ApidocsController < ActionController::Base
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'Open ToDo API'
      key :description, 'Open Todo API is an externally usable API for basic to-do list application.' \
                        'This API will allow users to modify user accounts and to-do items from the command line.'
      key :termsOfService, 'http://helloreverb.com/terms/'
      contact do
        key :name, 'Jocelyn Hsu'
      end
      license do
        key :name, 'MIT'
      end
    end
    tag do
      key :name, 'todo'
      key :description, 'Open Todo API app'
      externalDocs do
        key :description, 'Find more info here'
        key :url, 'https://swagger.io'
      end
    end
    key :host, 'still-headland-51006.herokuapp.com/'
    key :basePath, '/apidocs'
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [
    UsersController,
    User,
    ListsController,
    List,
    ItemsController,
    Item,
    ErrorModel,
    self,
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end
