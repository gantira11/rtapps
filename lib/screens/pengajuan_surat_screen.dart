import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtapp/components/button_block.dart';
import 'package:rtapp/components/text_input_default.dart';
import 'package:rtapp/constants.dart';
import 'package:rtapp/services/fire_firestore.dart';

class PengajuanSuratScreen extends StatefulWidget {
  const PengajuanSuratScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<PengajuanSuratScreen> createState() => _PengajuanSuratScreenState();
}

class _PengajuanSuratScreenState extends State<PengajuanSuratScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tempatLahirController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _jenisKelaminController = TextEditingController();
  final TextEditingController _agamaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final format = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 20,
          ),
        ),
        backgroundColor: primaryColor,
        title: Text(
          'Pengajuan Surat ' + widget.title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 19,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextInputDefault(
                  labelText: 'Nama Warga',
                  controller: _namaController,
                  keyboardType: TextInputType.text,
                  validator: (String? _nameController) {
                    if (_nameController == null || _nameController.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextInputDefault(
                  labelText: 'Tempat Lahir',
                  controller: _tempatLahirController,
                  keyboardType: TextInputType.text,
                  validator: (String? _tempatLahirController) {
                    if (_tempatLahirController == null ||
                        _tempatLahirController.isEmpty) {
                      return 'Tempat lahir tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                DateTimeField(
                  controller: _tanggalLahirController,
                  autovalidateMode: AutovalidateMode.always,
                  format: format,
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                      context: context,
                      initialDate: currentValue ?? DateTime.now(),
                      firstDate: DateTime(1800),
                      lastDate: DateTime(2100),
                    );
                  },
                  decoration: InputDecoration(
                    label: const Text('Tanggal Lahir'),
                    labelStyle: const TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: baseContentColor,
                    ),
                    counterText: '',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: baseContentColor,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: baseContentColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorStyle: const TextStyle(color: secondaryFocusColor),
                    focusColor: baseContentColor,
                    suffixIcon: const Icon(
                      Icons.date_range_outlined,
                      size: 22,
                    ),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        titlePadding: const EdgeInsets.all(10),
                        contentPadding: const EdgeInsets.all(10),
                        title: const Text(
                          'Pilih jenis kelamin',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        content: SizedBox(
                          width: 220,
                          height: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  _jenisKelaminController.text = 'Laki-laki';
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: SizedBox(
                                    width: size.width * 1,
                                    child: const Text(
                                      'Laki-laki',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: baseContentColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _jenisKelaminController.text = 'Perempuan';
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: SizedBox(
                                    width: size.width * 1,
                                    child: const Text(
                                      'Perempuan',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: baseContentColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: TextInputDefault(
                    labelText: 'Jenis Kelamin',
                    controller: _jenisKelaminController,
                    validator: (String? _jenisKelaminController) {
                      if (_jenisKelaminController == null ||
                          _jenisKelaminController.isEmpty) {
                        return 'Jenis Kelamin tidak boleh kosong';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    enabled: false,
                  ),
                ),
                const SizedBox(height: 15),
                TextInputDefault(
                  labelText: 'Agama',
                  controller: _agamaController,
                  keyboardType: TextInputType.text,
                  validator: (String? _agamaController) {
                    if (_agamaController == null || _agamaController.isEmpty) {
                      return 'Agama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextInputDefault(
                  labelText: 'Alamat',
                  controller: _alamatController,
                  keyboardType: TextInputType.multiline,
                  maxLine: 6,
                  validator: (String? _alamatController) {
                    if (_alamatController == null ||
                        _alamatController.isEmpty) {
                      return 'Alamat tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ButtonBlock(
          color: secondaryColor,
          buttonText: 'Submit',
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await FireFirestore.storeSurat(
                namaLengkap: _namaController.text,
                tempatLahir: _tempatLahirController.text,
                tanggalLahir: _tanggalLahirController.text,
                jenisKelamin: _jenisKelaminController.text,
                agama: _agamaController.text,
                alamat: _alamatController.text,
                jenisSurat: widget.title,
              );
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}
