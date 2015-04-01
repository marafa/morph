module ScrapersHelper
  def radio_description(repo)
    scraper = Scraper.where(full_name: repo.full_name).first
    if scraper
      a = content_tag(:strong, repo.name)
      a += " &mdash; #{repo.description}".html_safe unless repo.description.blank?
      content_tag(:p, a, class: "text-muted")
    else
      a = content_tag(:strong, repo.name)
      a += " &mdash; #{repo.description}".html_safe unless repo.description.blank?
      a += " (".html_safe + link_to("on GitHub", repo.rels[:html].href, target: "_blank") + ")".html_safe
      a
    end
  end

  def full_name_with_links(scraper)
    link_to(scraper.owner.to_param, scraper.owner) + " / " + link_to(scraper.name, scraper)
  end

  # Try to (sort of) handle the situation where text is not properly encoded
  # and so auto_link would normally fail
  def auto_link_fallback(text)
    begin
      auto_link(text)
    rescue Encoding::CompatibilityError
      text
    end
  end
end
