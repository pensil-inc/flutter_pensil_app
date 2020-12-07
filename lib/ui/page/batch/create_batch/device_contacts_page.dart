import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pensil_app/model/actor_model.dart';
import 'package:flutter_pensil_app/ui/widget/p_button.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';

// as _l_contacts_service;

class AllContactsPage extends StatefulWidget {
  const AllContactsPage({Key key, this.selectedFromDeviceContact})
      : super(key: key);
  final List<Contact> selectedFromDeviceContact;

  static MaterialPageRoute getRoute(List<Contact> selectedFromDeviceContact) {
    return MaterialPageRoute(
        builder: (_) => AllContactsPage(
            selectedFromDeviceContact: selectedFromDeviceContact));
  }

  @override
  _AllContactsPageState createState() => _AllContactsPageState();
}

class _AllContactsPageState extends State<AllContactsPage> {
  GetIt getIt = GetIt.instance;
  String searchTerm;

  List<Contact> _contacts;
  final List<Contact> _selectedContacts = [];
  List<Contact> selectedFromDeviceContact;
  bool _isUploading = false;

  @override
  void initState() {
    selectedFromDeviceContact = widget.selectedFromDeviceContact;
    _refreshContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          'Select Contacts',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: () async {
                searchTerm = await showDialog(
                  context: context,
                  builder: (BuildContext context) => _SearchDialog(),
                );
                if (searchTerm != null) {
                  _refreshContacts();
                }
              }),
          if (!_isUploading)
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () async {
                // final List<ContactsDatamodel> _listContacts = _selectedContacts
                //     .map((Contact contact) => ContactsDatamodel(
                //           name: contact.displayName ??
                //               contact.givenName ??
                //               'No name',
                //           contact: contact,
                //           img: contact.avatar != null &&
                //                   contact.avatar.isNotEmpty
                //               ? String.fromCharCodes(contact.avatar)
                //               : null,
                //         ))
                //     .toList();

                Navigator.pop(context, _selectedContacts);
              },
            )
          else
            Center(child: Text("Loading")),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: _contacts != null
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: _contacts?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final List<String> _contactsList = [];

                    final Contact _contact = _contacts?.elementAt(index);
                    if (_contact.phones.isNotEmpty) {
                      _contact.phones
                          .map((i) => _contactsList.add(i.value ?? 'Null'))
                          .toList();
                    } else {
                      _contactsList.add('Null');
                    }

                    return Card(
                      child: InkWell(
                        child: Container(
                          color: _selectedContacts.contains(_contact)
                              ? Theme.of(context).primaryColor
                              : null,
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                (_selectedContacts.contains(_contact))
                                    ? _selectedContacts.remove(_contact)
                                    : _selectedContacts.add(_contact);
                              });
                            },
                            leading: (_contact.avatar != null &&
                                    _contact.avatar.isNotEmpty)
                                ? CircleAvatar(
                                    backgroundImage:
                                        MemoryImage(_contact.avatar))
                                : CircleAvatar(
                                    child: Text(_contact.initials())),
                            title: Text(_contact.displayName ?? ""),
                            subtitle:
                                Text(_contact?.phones?.first?.value ?? "N/A"),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Future<void> _refreshContacts() async {
    PermissionStatus permissionStatus = await getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      final contacts = (await ContactsService.getContacts(
              withThumbnails: false, orderByGivenName: true))
          .toList();

      if (contacts != null && contacts.isNotEmpty) {
        contacts.removeWhere(
            (element) => element.phones.isEmpty || element.displayName == null);
        _contacts = searchTerm != null
            ? contacts.where((contact) {
                return (contact.displayName ?? contact.givenName ?? "")
                    .toLowerCase()
                    .contains(searchTerm);
              }).toList()
            : contacts;
        if (selectedFromDeviceContact != null) {
          contacts.forEach((contact) {
            selectedFromDeviceContact.forEach((model) {
              var isAvailable = model.displayName.toLowerCase() ==
                      contact.displayName.toLowerCase() &&
                  model.phones.join() == contact.phones.join();
              if (isAvailable) {
                setState(() {
                  _selectedContacts.add(contact);
                });
              }
            });
          });
          // for (final contact in contacts) {
          // ContactsService.getAvatar(contact).then((avatar) {
          //   if (selectedFromDeviceContact != null &&
          //       selectedFromDeviceContact.any(
          //           (element) => contact.phones.contains(element.mobile))) {
          //     setState(() {
          //       _selectedContacts.add(contact);
          //     });
          //   }
          //   if (avatar == null) return;

          //   contact.avatar = avatar;
          // });
          // }
        }

        setState(() {});
      }
    } else {
      handleInvalidPermissions(permissionStatus);
    }
  }
}

class _SearchDialog extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(
          top: 20,
          bottom: 20,
          left: 100,
          right: 100,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 10.0),
            TextField(
              controller: _controller,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              decoration: const InputDecoration(
                hintText: 'I\'M LOOKING FOR...',
              ),
            ),
            const SizedBox(height: 24.0),
            Align(
              alignment: Alignment.bottomRight,
              child: PFlatButton(
                onPressed: () {
                  Navigator.pop(context, _controller.text);
                },
                label: 'Search',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<PermissionStatus> getContactPermission() async {
  var permission = await Permission.contacts.status;
  if (permission != PermissionStatus.granted &&
      permission != PermissionStatus.restricted) {
    final permissionStatus = await Permission.contacts.request();
    return permissionStatus;
  } else {
    return permission;
  }
}

void handleInvalidPermissions(PermissionStatus permissionStatus) {
  if (permissionStatus == PermissionStatus.denied) {
    print("Access to location data denied");
    // throw PlatformException(
    //     code: "PERMISSION_DENIED",
    //     message: "Access to location data denied",
    //     details: null);
  } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
    print("Contact permission is permanentlyDenied");
    // throw PlatformException(
    //     code: "PERMISSION_DISABLED",
    //     message: "Location data is not available on device",
    //     details: null);
  }
}
