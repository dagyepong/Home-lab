### **fix dark colors:**

How to fix it in Ghost Admin:
You don't need to download your theme files to fix this! Ghost has a built-in feature called Code Injection:

Go to your Ghost Admin Dashboard (linuxpad.blog/ghost).

Click on the Settings Gear icon in the bottom left.

Select Code Injection from the menu.

In the Site Header box, paste this override code to force images back to full brightness


```html
<style>
/* Force images to stay at 100% brightness and opacity */
img, .kg-image-card img, .kg-gallery-card img {
    filter: none !important;
    opacity: 1 !important;
}
</style>

```