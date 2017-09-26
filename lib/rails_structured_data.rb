require "rails_structured_data/version"

module RailsStructuredData
  include ActionView::Helpers::TagHelper

  def self.for(record)
    data = calculate_data(record)
    
    str = ''
    data.each do |d|
      str << "<script type='application/ld+json'>#{d.to_json.html_safe}</script>"
    end
    str
  end

  ActiveSupport.on_load(:active_record) do
    class ActiveRecord::Base
      def self.structured_data(options={})
        class_attribute :structured_data

        self.structured_data ||= {}
        self.structured_data[:parent] = options[:parent]
      end
    end
  end

  private

  def self.calculate_data(record)
    if record.structured_data
      [self.breadcrumbs_for(record), self.product_for(record)]
    else
      []
    end
  end

  def self.breadcrumbs_for(record)
    if record.class.structured_data
      {
        "@context":"http://schema.org",
        "@type":"BreadcrumbList",
        "itemListElement": get_breadcrumb_items(record).reverse.each_with_index.map do |item, idx|
          item.merge({ "position": idx + 1 })
        end
      }
    else

    end
  end

  def self.get_breadcrumb_items(record)
    if record && record.class.structured_data
      parent_method = record.class.structured_data[:parent]
      myself = {
        "@type":"ListItem",
        "item":{
          "@id":"/#{record.class.name}/categories/3",
          "name": record.name,
          "image": nil
        }
      }
      
      debugger

      if parent_method && record.respond_to?(parent_method) && !record.send(parent_method).nil?
        [myself] + get_breadcrumb_items(record.send(parent_method))
      else
        [myself]
      end
    else
      []
    end
  end

  def self.product_for(record)
    { }
  end
end
