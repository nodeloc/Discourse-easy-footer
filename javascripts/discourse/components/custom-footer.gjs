import Component from "@glimmer/component";
import I18n from "discourse-i18n";
import dasherize from "discourse/helpers/dasherize";
import PluginOutlet from "discourse/components/plugin-outlet";
import icon from "discourse/helpers/d-icon";

export default class CustomFooter extends Component {
  localizeText(defaultText, translations) {
    if (!translations?.length) return defaultText;

    const raw = I18n.currentLocale().replace("-", "_");
    const lang = raw.split("_")[0];

    const match =
      translations.find((t) => t.locale === raw) ||
      translations.find((t) => t.locale === lang) ||
      translations.find((t) => raw.startsWith(t.locale));

    return match ? match.text : defaultText;
  }

  get mainHeading() {
    return this.localizeText(settings.heading, settings.heading_translations);
  }

  get blurb() {
    return this.localizeText(settings.blurb, settings.blurb_translations);
  }

  <template>
    {{#if @showFooter}}
      <div class="custom-footer">
        <div class="wrap">
          <div class="flexbox">
            <div class="first-box">
              <div class="heading">
                {{this.mainHeading}}
              </div>
              <div class="blurb">
                {{this.blurb}}
              </div>
            </div>
            <div class="second-box">
              <PluginOutlet @name="easy-footer-second-box">
                <div class="links">
                  {{#each settings.sections as |section|}}
                    <div
                      class="list"
                      data-easyfooter-section={{dasherize section.text}}
                    >
                      <span title={{section.title}}>
                        {{this.localizeText section.text section.translations}}
                      </span>

                      <ul>
                        {{#each section.links as |link|}}
                          <li
                            class="footer-section-link-wrapper"
                            data-easyfooter-link={{dasherize link.text}}
                          >
                            <a
                              class="footer-section-link"
                              title={{link.title}}
                              href={{link.url}}
                              target={{link.target}}
                              referrerpolicy={{link.referrer_policy}}
                            >
                              {{this.localizeText link.text link.translations}}
                            </a>
                          </li>
                        {{/each}}
                      </ul>
                    </div>
                  {{/each}}
                </div>
              </PluginOutlet>
            </div>

            <div class="third-box">
              <div class="footer-links">
                {{#each settings.small_links as |link|}}
                  <a
                    class="small-link"
                    data-easyfooter-small-link={{dasherize link.text}}
                    target={{link.target}}
                    href={{link.url}}
                  >
                    {{this.localizeText link.text link.translations}}
                  </a>
                {{/each}}
              </div>

              <div class="social">
                {{#each settings.social_links as |link|}}
                  <a
                    class="social-link"
                    data-easyfooter-social-link={{dasherize link.text}}
                    title={{link.title}}
                    target={{link.target}}
                    href={{link.url}}
                  >
                    {{icon link.icon_name}}
                  </a>
                {{/each}}
              </div>
            </div>
          </div>
        </div>
      </div>
    {{/if}}
  </template>
}
