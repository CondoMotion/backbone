module HomeHelper
  def pricing_link(plan)
    link_to pricing_link_text(plan), "sign_up/#{plan.id}", class: "plan pull-left center"
  end

  def pricing_link_text(plan)
    raw(plan.name + "<br>" + number_to_currency(plan.amount / 100) + " / " + plan.interval + "<br>" + "per property")
  end
end
