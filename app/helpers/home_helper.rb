module HomeHelper
  def pricing_link(plan)
    link_to pricing_link_text(plan), "sign_up/#{plan.name}", class: "plan pull-left center"
  end

  def pricing_link_text(plan)
    raw(plan.name.titleize + "<br>" + number_to_currency(plan.amount) + " / " + plan.interval + "<br>" + "per property")
  end
end
