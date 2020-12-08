import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pensil_app/model/actor_model.dart';
import 'package:flutter_pensil_app/ui/widget/form/p_textfield.dart';
import 'package:flutter_pensil_app/ui/widget/p_button.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';

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
  TextEditingController search;

  @override
  void initState() {
    selectedFromDeviceContact = widget.selectedFromDeviceContact;
    search = TextEditingController();
    _refreshContacts(initial: true);
    super.initState();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
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
            icon: Icon(Icons.done),
            onPressed: () async {
              Navigator.pop(context, _selectedContacts);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: _contacts != null
              ? Column(
                  children: [
                    PTextField(
                      controller: search,
                      type: Type.text,
                      onChange: (val) {
                        searchTerm = val;
                        _refreshContacts();
                      },
                      label: "Search",
                    ),
                    ListView.builder(
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

                        bool isSelected = _selectedContacts.any((model) =>
                            model.identifier == _contact.identifier &&
                            model.phones.join() == _contact.phones.join() &&
                            model.displayName == _contact.displayName);

                        return Card(
                          child: InkWell(
                            child: Container(
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : null,
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      _selectedContacts.removeWhere((model) =>
                                          model.identifier ==
                                          _contact.identifier);
                                      print(
                                          "removed: list length ${_selectedContacts.length}");
                                    } else {
                                      _selectedContacts.add(_contact);
                                      print("print");
                                    }
                                  });
                                },
                                leading: (_contact.avatar != null &&
                                        _contact.avatar.isNotEmpty)
                                    ? CircleAvatar(
                                        backgroundImage:
                                            MemoryImage(_contact.avatar))
                                    : CircleAvatar(
                                        child: Text(_contact.initials())),
                                title: Text(
                                  _contact.displayName ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black),
                                ),
                                subtitle: Text(
                                  _contact?.phones?.first?.value ?? "N/A",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ).extended,
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Future<void> _refreshContacts({bool initial = false}) async {
    PermissionStatus permissionStatus = await getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      final contacts = (await ContactsService.getContacts(
              withThumbnails: false, orderByGivenName: true))
          .toList();

      if (contacts != null && contacts.isNotEmpty) {
        /// Remove contacts having null contact or Display name
        contacts.removeWhere(
            (element) => element.phones.isEmpty || element.displayName == null);

        /// Apply search
        _contacts = searchTerm != null
            ? contacts.where((contact) {
                return (contact.displayName ?? contact.givenName ?? "")
                        .toLowerCase()
                        .contains(searchTerm.toLowerCase()) ||
                    contact.phones
                        .any((element) => element.value.contains(searchTerm));
              }).toList()
            : contacts;

        /// Mark preselected contacts
        if (initial &&
            selectedFromDeviceContact != null &&
            selectedFromDeviceContact.isNotEmpty) {
          _selectedContacts.clear();
          contacts.forEach((contact) {
            selectedFromDeviceContact.forEach((model) {
              var isAvailable = model.displayName.toLowerCase() ==
                      contact.displayName.toLowerCase() &&
                  model.phones.join() == contact.phones.join();
              if (isAvailable) {
                setState(() {
                  /// Check for duplicacy
                  if (!_selectedContacts.contains(contact))
                    _selectedContacts.add(contact);
                });
              }
            });
          });
        } else {
          print("Access");
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
  } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
    print("Contact permission is permanentlyDenied");
  }
}
