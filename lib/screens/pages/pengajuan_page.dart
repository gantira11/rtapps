import 'package:flutter/material.dart';
import 'package:rtapp/constants.dart';
import 'package:rtapp/routes/router_generator.dart';

class PengajuanPage extends StatefulWidget {
  const PengajuanPage({Key? key}) : super(key: key);

  @override
  State<PengajuanPage> createState() => _PengajuanPageState();
}

class _PengajuanPageState extends State<PengajuanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: const Text(
          'Pengajuan Surat',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            color: baseContentColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Card(
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Pengajuan Surat',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: baseContentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
                FlatButton(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'pengajuan-surat',
                      arguments: SuratArguments('SKTM'),
                    );
                  },
                  titleButton: 'SKTM (Surat Keterangan Tidak Mampu)',
                ),
                FlatButton(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'pengajuan-surat',
                      arguments: SuratArguments('Surat Keterangan'),
                    );
                  },
                  titleButton: 'Surat Keterangan',
                ),
                FlatButton(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'pengajuan-surat',
                      arguments: SuratArguments('Surat Pindah'),
                    );
                  },
                  titleButton: 'Surat Pindah',
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Struktur RT',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: baseContentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
                FlatButton(
                  titleButton: 'Lihat Struktural Pengurus',
                  onTap: () {
                    Navigator.pushNamed(context, 'struktur-pengurus');
                  },
                ),
                FlatButton(
                  titleButton: 'Lihat Struktural Masjid',
                  onTap: () {
                    Navigator.pushNamed(context, 'struktur-masjid');
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FlatButton extends StatelessWidget {
  const FlatButton({
    Key? key,
    required this.titleButton,
    required this.onTap,
  }) : super(key: key);

  final String titleButton;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: baseColor,
          ),
        )),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                titleButton,
                style: const TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Icon(
                Icons.navigate_next_outlined,
                color: baseContentColor,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
