NAMD
----

NAMD uses a non-commercial license. A disclaimer is printed when the module is loaded.

Installation
============

[Release Notes](https://www.ks.uiuc.edu/Research/namd/cvs/notes.html)

1. A NAMD account is needed to download binaries
2. Create new directory `/opt/psi/MPI/NAMD/$VERSION`
3. Download the latest binary.
   - Use `NAMD_$VERSION_Linux-x86_64-verbs-smp-CUDA.tar.gz` for _gpu
   - Use `NAMD_$VERSION_Linux-x86_64-verbs-smp.tar.gz` for non-gpu

4. Unpack to the new directory with `tar -xzvf NAMD*.tar.gz --strip-components=1 -C /opt/psi/MPI/NAMD/$VERSION`
5. Clean up:

    mkdir bin
    find . -maxdepth 1 -executable -type f -exec mv '{}' bin ';'

6. Add new variant to files/variants
7. Run the build-script to install the modulefile and to set the release

