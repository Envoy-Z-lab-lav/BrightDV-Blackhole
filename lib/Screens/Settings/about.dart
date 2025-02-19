/*
 *  This file is part of BlackHole (https://github.com/BrightDV/BlackHole).
 * 
 * BlackHole is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * BlackHole is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with BlackHole.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Copyright (c) 2021-2023, Ankit Sangwan
 */

import 'package:blackhole/CustomWidgets/gradient_containers.dart';
import 'package:blackhole/CustomWidgets/snackbar.dart';
import 'package:blackhole/Helpers/github.dart';
import 'package:blackhole/Helpers/update.dart';
import 'package:flutter/material.dart';
import 'package:blackhole/localization/generated/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String? appVersion;

  @override
  void initState() {
    main();
    super.initState();
  }

  Future<void> main() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    setState(
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(
              context,
            )!
                .about,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    10.0,
                    10.0,
                    10.0,
                    10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          AppLocalizations.of(
                            context,
                          )!
                              .version,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(
                            context,
                          )!
                              .versionSub,
                        ),
                        onTap: () {
                          ShowSnackBar().showSnackBar(
                            context,
                            AppLocalizations.of(
                              context,
                            )!
                                .checkingUpdate,
                            noAction: true,
                          );

                          GitHub.getLatestVersion().then(
                            (String latestVersion) async {
                              if (compareVersion(
                                latestVersion,
                                appVersion!,
                              )) {
                                ShowSnackBar().showSnackBar(
                                  context,
                                  AppLocalizations.of(context)!.updateAvailable,
                                  duration: const Duration(seconds: 15),
                                  action: SnackBarAction(
                                    textColor:
                                        Theme.of(context).colorScheme.secondary,
                                    label: AppLocalizations.of(context)!.update,
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      launchUrl(
                                        Uri.parse(
                                          'https://github.com/BrightDV/BlackHole/releases',
                                        ),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    },
                                  ),
                                );
                              } else {
                                ShowSnackBar().showSnackBar(
                                  context,
                                  AppLocalizations.of(
                                    context,
                                  )!
                                      .latest,
                                );
                              }
                            },
                          );
                        },
                        trailing: Text(
                          'v$appVersion',
                          style: const TextStyle(fontSize: 12),
                        ),
                        dense: true,
                      ),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(
                            context,
                          )!
                              .shareApp,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(
                            context,
                          )!
                              .shareAppSub,
                        ),
                        onTap: () {
                          Share.share(
                            '${AppLocalizations.of(
                              context,
                            )!.shareAppText}: https://BrightDV.github.io/',
                          );
                        },
                        dense: true,
                      ),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(
                            context,
                          )!
                              .likedWork,
                        ),
                        subtitle: const Text(
                          'Github Sponsors',
                        ),
                        dense: true,
                        onTap: () {
                          launchUrl(
                            Uri.parse(
                              'https://github.com/sponsors/BrightDV',
                            ),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                      ),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(
                            context,
                          )!
                              .moreInfo,
                        ),
                        dense: true,
                        onTap: () {
                          Navigator.pushNamed(context, '/about');
                        },
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: <Widget>[
                  const Spacer(),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 30, 5, 20),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.madeBy,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
