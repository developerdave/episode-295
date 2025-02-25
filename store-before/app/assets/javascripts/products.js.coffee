jQuery ->
  if $('#products').length
    new ProductsPager()

class ProductsPager
  constructor: (@page = 1) ->
    $(window).scroll(@check)

  check: =>
    if @nearBottom()
      @page++
      $(window).unbind('scroll', @check)
      $.getJSON($('#products').data('json-url'), page: @page, @render)

  nearBottom: =>
    $(window).scrollTop() > $(document).height() - $(window).height() - 50

  render: (products) =>
      for product in products
        $('#products').append Mustache.to_html($('#product_template').html(), product)
      $(window).scroll(@check) if products.length > 0
