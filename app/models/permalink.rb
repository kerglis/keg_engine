module Permalink
  def self.included(base)
    base.class_eval do

      # def param_str(locale = nil)
      #   Globalize.with_locale(locale) do
      #     to_param
      #   end
      # end

      def to_param(method = :name)
        parents = self_and_ancestors rescue nil

        parts = if parents
          [ id, parents.map{|p| p.permalink(method)} ]
        else
          [ id, permalink ]
        end

        parts.compact.join("-")
      end

      def permalink(method = :name)
        send(method).try(:to_url) rescue ""
      end

      def path(locale, params = {})
        method = self.class.to_s.underscore
        Rails.application.routes.url_helpers.send("#{method}_path", self, params.merge({locale: locale})).gsub(/#{param_str}$/, to_param)
      end

    end
  end
end