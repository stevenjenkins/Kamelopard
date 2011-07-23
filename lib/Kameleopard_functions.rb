def fly_to(p, d = 0, r = 100, m = nil)
    m = Document.instance.flyto_mode if m.nil?
    FlyTo.new(p, r, d, m)
end

def set_flyto_mode_to(a)
    Document.instance.flyto_mode = a
end

def mod_popup_for(p, v)
    a = AnimatedUpdate.new
    if ! p.is_a? Placemark then
        raise "Can't show popups for things that aren't placemarks"
    end
    a << "<Change><Placemark targetId=\"#{p.id}\"><visibility>#{v}</visibility></Placemark></Change>"
end

def hide_popup_for(p)
    mod_popup_for(p, 0)
end

def show_popup_for(p)
    mod_popup_for(p, 1)
end

def point(lo, la, alt=0, mode=nil, extrude = false)
    Point.new(lo, la, alt, mode.nil? ? :clampToGround : mode, extrude)
end

def get_kml
    Document.instance.to_kml
end

def pause(p)
    Wait.new p
end

def name_tour(a)
    Document.instance.tour.name = a
end

def name_folder(a)
    Document.instance.folder.name = a
end

def zoom_out(dist = 1000, dur = 0, mode = nil)
    l = Document.instance.tour.last_abs_view
    raise "No current position to zoom out from\n" if l.nil?
    l.range += dist
    FlyTo.new(l, nil, dur, mode)
end

def set_spline_type(a)
    case a
    when 'linear'
        Document.instance.spline_type = GSL::Interp::LINEAER
    when 'akima'
        Document.instance.spline_type = GSL::Interp::AKIMA
    when 'akima_periodic'
        Document.instance.spline_type = GSL::Interp::AKIMA_PERIODIC
    when 'cspline'
        Document.instance.spline_type = GSL::Interp::CSPLINE
    when 'cspline_periodic'
        Document.instance.spline_type = GSL::Interp::CSPLINE_PERIODIC
    when 'polynomial'
        Document.instance.spline_type = GSL::Interp::POLYNOMIAL
    else
        raise "Invalid spline type #{a}. Valid options are: linear, cspline, cspline_periodic, akima, akima_periodic, polynomial"
end

def set_interp_step(a)
    Document.instance.spline_step = a
end
