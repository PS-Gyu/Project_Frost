using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DarkMusSec : MonoBehaviour
{
    public static bool secDial = false;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            if (!secDial)
            {
                secDial = true;
            }

        }
    }
}
