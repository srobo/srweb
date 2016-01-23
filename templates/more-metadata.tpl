{assign var="description" value="{getFromContent get='description'}"}
{if !empty($description)}
    <meta name="twitter:card" content="summary" />
    <meta name="twitter:site" content="@StudentRobotics" />
    <meta name="twitter:title" content="{getFromContent get='title'}" />
    <meta name="twitter:description" content="{getFromContent get='description'}" />
    <meta name="twitter:url" content="{$base_uri}{$page_uri}" />

    {* Facebook uses Open Graph *}
    <meta property="og:title" content="{getFromContent get='title'}" />
    <meta property="og:description" content="{getFromContent get='description'}" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="{$base_uri}{$page_uri}" />
{/if}
