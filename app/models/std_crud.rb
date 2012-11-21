module StdCrud

  def self.included(base)

    base.instance_eval do
      load_and_authorize_resource
    end

    base.class_eval do
      [:destroy, :swap].each do |method|
        define_method method do |arg|
          self.send "#{method}_object"
        end
      end

      def create
        create! do |success, failure|
          success.html { redirect_to edit_resource_url }
        end
      end

      def update
        update! do |success, failure|
          success.html { redirect_to edit_resource_url }
        end
      end

    end
  end

end
