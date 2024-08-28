Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      post 'add' => 'operations#add'
      post 'subtract' => 'operations#subtract'
    end
  end
end
