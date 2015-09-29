module ApplicationHelper

  def all_incidents
    Incident.all.order('updated_at DESC')
  end

  def visible_incidents
    @visible_incidents = []
    if signed_in?
      @visible_incidents = all_incidents.to_a
    else
      all_incidents.each do |i|
        @visible_incidents << i if i.public
      end
    end
    @visible_incidents
  end

  def active_incidents
    @active_incidents = []
    visible_incidents.each do |i|
      @active_incidents << i if i.active
    end
    @active_incidents
  end

  def inactive_incidents
    @inactive_incidents = []
    visible_incidents.each do |i|
      @inactive_incidents << i unless i.active
    end
    @inactive_incidents
  end

  def all_events(incident)
    return unless incident.is_a? Incident
    all_events ||= incident.events.order('updated_at DESC')
  end

  def last_event(incident)
    return unless incident.is_a? Incident
    last_event ||= all_events(incident).first
  end

  def dated_incidents
    # Returns a hash containing dates and the incidents that happened on that date
    # Sample output
    # {Sat, 26 Sep 2015=>#<ActiveRecord::Relation [#<Incident id: 980190979, name: "Incident Name", component: "Incident...>>}
    # Says 'nothing to report' if there are no incidents on that day
    # This is a bit heavy, especially if Statusify has been around for some time.
    begins = Incident.first.created_at.to_date
    ends = Incident.last.updated_at.to_date
    # Minor check to make sure things don't blow up
    begins,ends = ends,begins if begins > ends
    # The range over which we operate
    range = begins..ends
    # Runs only if @dated_incidents == nil
    unless @dated_incidents
      @dated_incidents = Hash.new
      range.each do |date|
        i = Incident.where(:created_at => date.beginning_of_day..date.end_of_day)
        if !i.empty?
          @dated_incidents[date] = i
        else
          @dated_incidents[date] = 'Nothing to report'
        end
      end
    end
    Hash[@dated_incidents.sort{|a,b| b <=> a}.to_h]
  end

end
