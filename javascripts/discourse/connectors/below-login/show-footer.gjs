import { not } from "discourse/truth-helpers";
import hideApplicationFooter from "discourse/helpers/hide-application-footer";

<template>
  {{#if (not settings.show_footer_on_login_required_page)}}
    {{hideApplicationFooter}}
  {{/if}}
</template>
