# Barito Loki Cookbook

Chef cookbook for provisioning Barito Loki

## Releasing New Version

We need to do these whenever we release a new version:

1. Run
```
bundle exec berks update
bundle exec berks vendor cookbooks
```

2. Commit and updated `cookbooks` directory
3. Tag the commit that we want to release with format `<APP-VERSION>-<REVISION>`

## Version

This cookbook version will follow barito flow version with extra revision indicator suffixed. For example:

- `0.1.0-1` means that this is a revision 1 cookbook that will provision barito flow version `0.1.0`
