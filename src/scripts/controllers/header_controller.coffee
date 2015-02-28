###
Crafting Guide - header_controller.coffee

Copyright (c) 2015 by Redwood Labs
All rights reserved.
###

BaseController = require './base_controller'

########################################################################################################################

module.exports = class HeaderController extends BaseController

    constructor: (options={})->
        super options

    # Event Methods ################################################################################

    onLogoClicked: ->
        router.navigate '/', trigger:true
        return false

    onNavItemClicked: (event)->
        return true unless $(event.currentTarget).attr('href')?

        router.navigate $(event.currentTarget).attr('href'), trigger:true
        return false

    # BaseController Overrides #####################################################################

    render: ->
        # Overriding render because the header is already part of the stock page layout, and we
        # don't need to replace it here.
        @_rendered = true

        @$navLinks = ($(el) for el in @$('.navBar a'))

        zIndex = @$navLinks.length + 100
        for $navLink in @$navLinks
            $navLink.css 'z-index', zIndex--

    refresh: ->
        for $navLink in @$navLinks
            logger.debug "@model: #{@model}, page: #{$navLink.data('page')}"
            if $navLink.data('page') is @model
                $navLink.addClass 'selected'
            else
                $navLink.removeClass 'selected'

    # Backbone.View Overrides ######################################################################

    events: ->
        return _.extend super,
            'click a.logo':    'onLogoClicked'
            'click .navBar a': 'onNavItemClicked'
