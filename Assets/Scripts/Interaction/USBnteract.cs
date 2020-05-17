using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class USBnteract : MonoBehaviour
{
    public bool usbInteracted = true;
    public static bool isInteracted = true;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    

    // Update is called once per frame
    void Update()
    {
        isInteracted = usbInteracted;
    }

}
