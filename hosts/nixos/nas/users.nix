{ config, ... }:

{
  sops.secrets.root-password = {
    key = "root";
    sopsFile = ./../secrets/user-passwords.yaml;
    neededForUsers = true;
  };

  users = {
    mutableUsers = false;

    users = {
      truelecter = {
        uid = 1000;
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" ];
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDTOJqJJ2X5bYAJ8Za8+4TwnAPNm7axzl3ArGgiANK0lcJeZUWk8rNe10qDZTqHEfdq5sJw8iNm7jaQIsbov3OexkOQJwegJnFrbHIi5FXmKgEkGNuoxg3d8I0zQATZdY+VAhtZ5FDRJEit0+H62gRdLz6/d/kTuZlW420XapDQxRK3sGi0xM0ZejzhhxjotNx6apNsOCIE6I9ty4ouuPWJxQoAUG8kj1BKB5yMcl4biSXswmxS32iYYFe4yI76OrOXKLWiIbKfWwCG2Rh5urNRx7n8NhU1Hk3wHyqrqJvX7Lhj4kDFEt+RfhacDwCSckoWbQUrtMcByFl2WKv3zZJ1nOGUSMcc+gl2IzJdJMm/4mA0SZTC9s5GKw6BevFbr1UvwNd6p7zdOGRoVQDyALbvgzh5h8EysvYVe2zGOJGMgWg1v7lxLt9WthlBNToN8QTx7Wf01Tr0u17LHgLc8Y6UOn/i6L25E7HWd0QsB2G7XFN1jdi6VsQtLpRrBewz//Y6V5sL1FrATK4j/D+9eUy+KZ9/fGPlEJ1ZjVIgnZ39O9czWZf2vhCGY3JsJgrDgyHwD6yNt9sbf+4VVB/wsvxPmIUihr+n7iNeffwa955S4Xaa5yvtz18PlgmvTOicJzm3FDbSFo8ADkK53lCIZ+7uw1rj1yeQt6J98GQ1khVBvQ== andrii.panasiuk@Andrii.Panasiuk"
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYKTlyWIGFv0GlrysdzueaXSdHOYkm35OaWsshTr0dHehFZXwWKqXms2tELy9fec2W+kr1gVFuvJcSg9wZltYuHC2OGKXhl8YITYVjSQyqd6isfGdL/HTP4psrICcpBGjmxFR7pCUcjbpF02J/HS57YC1wMEruidIm7rhwHvXIIKfCTa5BYyDaY+xEmrqFyEK2EyJ9TanaYZRE34pd+UYY2A+uKmhR7DLb/o8VlCjE8yHrq2x+kpzFMamQ2Kz4OIFejBNnBsgWK5vTlRG4xpizIDJnunIvTnj2cQqcyMLEbeJ6WIO8KolG4RcMmV2iJhuFopCYrGsAfTNyn4TprHm8D1fw95UeVEF53fyRL/REyIqazPXiMPRtYV/eH2km65j3RW1T80fFo8ueFAuKJU6uTomDbbqSmU9SbBabjlZoJWqi8BMTyX5f3xreNkM6bplca/yAMNq5KMIOlSHanak0tbV+UK4TEjAcJJuqUIvWaG1JlWGaKFmXNmwnTpC8xQhE5Iv6wv07zhXyqEi9xIQLAT5pHmP0Rf/elKObOur1epTFEapUyQ6Xfx1QmrP4zBR2WhCP2WzJsM/fGsd2fk75eQQ3W6HPIe5tD4qKZeHMGD7Ar8JyqyiXFKGtaZq/pKpG8V9nlEbSznS1CuBtvWAlvx4IVBYXq6SKfO0MgM+6Dw== cardno:18 283 211"
        ];
      };

      root = {
        passwordFile = config.sops.secrets.root-password.path;
      };
    };
  };
}
